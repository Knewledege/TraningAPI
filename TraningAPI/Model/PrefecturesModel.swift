//
//  InfectedUser.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/14.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Foundation
//import PromiseKit


protocol PrefecturesInput{
    func GetPregectures(updateComp:Bool, completion: @escaping (Result<[Prefectures], APIError>) -> Void)
    func GetDetails(id: Int)
    var prefectures: [Prefectures] { get }
    var details: Prefectures! { get }
}

class PrefecturesModel{
    internal var prefectures: [Prefectures] = []
    internal var details: Prefectures!
    private let api:GithubAPI
   
    init(api: GithubAPI = GithubAPI()){
        self.api = api
    }
}


extension PrefecturesModel:PrefecturesInput{
    ///都道府県情報一覧取得
    func GetPregectures(updateComp:Bool, completion: @escaping (Result<[Prefectures], APIError>) -> Void){
        
        //最終更新時間が1分以内か
        var differenceResult:Bool
        //データベース全取得
        let dbResult = RealmDB.GetPrefecturesByRealmDB()
        
        if updateComp {
            //データがあるため最終更新時間を判定
            if let result = dbResult{
                self.prefectures = result
                differenceResult = GetLastUpdate(updated: result.first?.updated)
            }else{
            //新規のためAPIを叩く
                differenceResult = true
            }
        }else{
            differenceResult = true
        }
            
        //1分以上のため再取得
        if differenceResult {
            self.api.PrefecturesAPI(callback: { (result,error) in
                print("結果をコールバックで返す")
                if let error = error{
                    print("エラー内容：",error)
                    completion(.failure(error))
                }
                if let data = result{
                    if let decodePrefectures = DecodePrefectures(data: data).prefectures{
                        self.prefectures = decodePrefectures
                        if dbResult == nil {
                            RealmDB.SetPrefecturesOnRealmDB(prefectures: self.prefectures)
                        }else{
                            RealmDB.UpdatePrefecturesOnRealmDB(prefectures: self.prefectures)
                        }
                        completion(.success(self.prefectures))
                    }else{
                        completion(.failure(APIError.decodeError))
                    }
                    
                }
            })
        }else{
            completion(.success(self.prefectures))
        }
    }
    private func GetLastUpdate(updated: Date?) -> Bool{
        if let lastUpdate = updated{
            let difference = Calendar.current.dateComponents([.minute], from: lastUpdate, to: Date()).minute ?? 0
                 if difference > 1{
                     return true
                 }
        }else{
            return true
        }
        return false
    }
    internal func GetDetails(id: Int){
        self.details = RealmDB.GetprefecturesByID(id: id)
    }
    
}
