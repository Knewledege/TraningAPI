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
    var details: Prefectures! { get }
}

class PrefecturesModel{
    internal var prefectures: [Prefectures]? = []
    internal var details: Prefectures!
    private let api:GithubAPI
    let realm = try! Realm()
    init(api: GithubAPI = GithubAPI()){
        self.api = api
    }
}


extension PrefecturesModel:PrefecturesInput{
    ///都道府県情報一覧取得
    func GetPregectures(completion: @escaping ([Prefectures]?) -> Void){
        
        //最終更新時間が1分以内か
        var differenceResult:Bool
        //データベース全取得
        let dbResult = GetPrefecturesByRealmDB()
        
        //データがあるため最終更新時間を判定
        if let result = dbResult{
            self.prefectures = result
            differenceResult = GetLastUpdate(updated: result.first?.updated)
        }else{
        //新規のためAPIを叩く
            differenceResult = true
        }
            
        //1分以上のため再取得
        if differenceResult {
            self.api.PrefecturesAPI(callback: { (result,error) in
                print("結果をコールバックで返す")
                if let error = error{
                    print("エラー内容：",error)
                }
                if let result = result{
                    self.prefectures = DecodePrefectures(data: result).prefectures
                    completion(self.prefectures)
                    if self.prefectures != nil {
                        if dbResult == nil {
                            self.SetPrefecturesOnRealmDB(prefectures: self.prefectures!)
                        }else{
                            self.UpdatePrefecturesOnRealmDB(prefectures: self.prefectures!)
                        }
                    }
                }
            })
        }else{
            completion(self.prefectures)
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
    private func SetPrefecturesOnRealmDB(prefectures:[Prefectures]){
        
        do {
            try self.realm.write {
                self.realm.add(prefectures)
            }
        } catch {
        }
    }
    private func UpdatePrefecturesOnRealmDB(prefectures:[Prefectures]){
        do {
            
            try self.realm.write {
             realm.add(prefectures, update: .modified)
            }
        } catch {
        }
    }
    private func GetPrefecturesByRealmDB() -> [Prefectures]?{
        var prefectures:[Prefectures]? = [Prefectures]()
        //全権取得
        let results = realm.objects(Prefectures.self)
//            print(results)
        let count = results.count
        if (count != 0) {
            results.forEach{ prefectures?.append($0)}
        }else{
            return nil
        }
        return prefectures
    }
    func GetprefecturesByID(id: Int){
        //全権取得
        if let result = realm.object(ofType: Prefectures.self, forPrimaryKey: id){
            self.details = result
        }
    }
}
