//
//  InfectedUser.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/14.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Foundation
import PromiseKit
import Reachability


protocol PrefecturesInput{
    func GetPregectures(executionRequest:Bool) -> Promise<[Prefectures]>
    func GetDetails(id: Int)
    var prefectures: [Prefectures] { get }
    var details: Prefectures! { get }
}

class PrefecturesModel{
    internal var prefectures: [Prefectures] = []
    internal var details: Prefectures!
    private let api:GithubAPI!
   
    init(api: GithubAPI = GithubAPI()){
        self.api = api
    }
    deinit {
        print("model deinit")
    }
}


extension PrefecturesModel:PrefecturesInput{
    //    MARK: - 都道府県情報一覧取得
    /// - Parameters:
    ///   -executionRequest:  TRUE:DBから取得  FALSE:APIから取得　呼び出し元の依頼
    func GetPregectures(executionRequest:Bool) -> Promise<[Prefectures]>{
  
        let (promise, resolver) = Promise<[Prefectures]>.pending()
        
        //true:APIを叩く, false:DBの値を使う
        var execution:Bool
        //DB全取得
        let dbResult = RealmDB.GetPrefecturesByRealmDB()
        
        if executionRequest {
            //DBにデータがあるため最終更新時間を判定
            if let result = dbResult{
                self.prefectures = result
                ///最終更新時間が1分以内ならDBのデータを採用
                execution = GetLastUpdate(updated: result.first?.updated)
            }else{
            //DBのデータがないためAPIを叩く
                execution = true
            }
        }else{
            execution = true
        }
        
        //圏外だったらDBを採用
        do{
            let reachability = try Reachability()
            if reachability.connection == .unavailable {
                //圏外かつDBにデータがない時はエラーを吐かせる
                if dbResult == nil {
                    resolver.reject(APIError.networkError)
                }else{
                    execution = false
                }
            }
        }catch{
            print("Reachabilityのインスタンス生成に失敗しました")
        }
            
        //1分以上もしくは再更新の依頼のためAPI取得
        if execution {
            firstly {
                //APIを取得
                self.api.PrefecturesAPI()
            }.then{ result in
                //APIのレスポンスをデコード
                DecodePrefectures.JsonDecode(data: result)
            }.done{ prefectures in//staticメソッドだから強参照ではないと考え [weak self]を除外　[weak self]に関してはもう少し理解が必要
                
                self.prefectures = prefectures
                if dbResult == nil {
                    //データベースに追加
                    RealmDB.SetPrefecturesOnRealmDB(prefectures: self.prefectures)
                }else{
                    //データベースを更新
                    RealmDB.UpdatePrefecturesOnRealmDB(prefectures: self.prefectures)
                }
                resolver.fulfill(self.prefectures)
            }.catch{ error in
                resolver.reject(error)
            }
        }else{
            resolver.fulfill(self.prefectures)
        }
        return promise
    }
    
    //    MARK: - 最終更新時間比較
    private func GetLastUpdate(updated: Date?) -> Bool{
        if let lastUpdate = updated{
            //分単位で比較
            let difference = Calendar.current.dateComponents([.minute], from: lastUpdate, to: Date()).minute ?? 0
                 if difference > 1{
                     return true
                 }
        }else{
            return true
        }
        return false
    }
    //    MARK: - 該当レコードをデータベースより取得
    internal func GetDetails(id: Int){
        self.details = RealmDB.GetprefecturesByID(id: id)
    }
    
}
