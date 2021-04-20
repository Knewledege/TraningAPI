//
//  InfectedUser.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/14.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Foundation
import PromiseKit
import RealmSwift

protocol PrefecturesInput{
    func GetPregectures(completion: @escaping ([Prefectures]?) -> Void)
    func GetprefecturesByID(id: Int)
    var prefectures: [Prefectures]? { get }
    var details: Prefectures? { get }
}

class PrefecturesModel{
    internal var prefectures: [Prefectures]? = []
    internal var details: Prefectures? = nil
    private let api:GithubAPI
    // Realmのインスタンスを準備
    let realm = try! Realm()

    
    init(api: GithubAPI = GithubAPI()){
        self.api = api
    }
}


extension PrefecturesModel:PrefecturesInput{
    ///都道府県情報一覧取得
    func GetPregectures(completion: @escaping ([Prefectures]?) -> Void){

        self.prefectures = GetPrefecturesByRealmDB()
        if self.prefectures == nil {
            ///API処理
            self.api.PrefecturesAPI(callback: { (result,error) in
                print("結果をコールバックで返す")
                if let error = error{
                    print("エラー内容：",error)

                }
                if let result = result{
                    self.prefectures = DecodePrefectures(data: result).prefectures
                    completion(self.prefectures)
                    
                    if self.prefectures != nil {
                        // 書き込み
                        print(Realm.Configuration.defaultConfiguration.fileURL!)
                        try! self.realm.write {
                            self.realm.add(self.prefectures!)
                        }
                    }
                }
            })
        }else{
            completion(self.prefectures)
        }
    }
    
    private func GetPrefecturesByRealmDB() -> [Prefectures]?{
        let realm: Realm
        var prefectures:[Prefectures]? = [Prefectures]()
        do {
            realm = try Realm()

            //全権取得
            let results = realm.objects(Prefectures.self)
//            print(results)
            let count = results.count
            if (count != 0) {
                results.forEach{ prefectures?.append($0)}

                print("DBから取得できた")
            }else{
                return nil
            }
        } catch {
            return nil
        }
        return prefectures
    }
    func GetprefecturesByID(id: Int){
        
        
    }
}
