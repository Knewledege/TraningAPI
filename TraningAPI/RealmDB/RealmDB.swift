//
//  RealmDB.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/21.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDB{
    static let realm = try! Realm()
    
    static func SetPrefecturesOnRealmDB(prefectures:[Prefectures]){
        do {
            try self.realm.write {
                self.realm.add(prefectures)
            }
        } catch {
        }
    }
    static func UpdatePrefecturesOnRealmDB(prefectures:[Prefectures]){
        do {
            try self.realm.write {
                self.realm.add(prefectures, update: .modified)
            }
            } catch {
        }
    }
    static func GetPrefecturesByRealmDB() -> [Prefectures]?{
        var prefectures:[Prefectures]? = [Prefectures]()
        //全権取得
        let results = self.realm.objects(Prefectures.self)
        let count = results.count
        if (count != 0) {
            results.forEach{ prefectures?.append($0)}
        }else{
            return nil
        }
        return prefectures
    }
    static func GetprefecturesByID(id: Int) -> Prefectures?{
        //全権取得
        if let result = self.realm.object(ofType: Prefectures.self, forPrimaryKey: id){
            return result
        }
        return nil
    }
}
