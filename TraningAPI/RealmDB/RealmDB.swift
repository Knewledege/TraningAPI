//
//  RealmDB.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/21.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmDB{
    
    static let realm = try! Realm()
    
    //    MARK: - Create Record　レコードを追加
    ///
    /// - Parameters:
    ///   - prefectures:Prefecturesクラスの配列
    static func SetPrefecturesOnRealmDB(prefectures:[Prefectures]){
        do {
            try self.realm.write {
                self.realm.add(prefectures)
            }
        } catch {
        }
    }
    //    MARK: - Update Record　レコードを更新
    ///
    /// - Parameters:
    ///   - prefectures:Prefecturesクラスの配列
    static func UpdatePrefecturesOnRealmDB(prefectures:[Prefectures]){
        do {
            try self.realm.write {
                self.realm.add(prefectures, update: .modified)
            }
            } catch {
        }
    }
    //    MARK: - Get All Record　全レコードを取得
    ///
    /// - Returns:Prefecturesクラスの配列
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
    //    MARK: - Get A Record　該当レコードを取得
    ///
    /// - Parameters:
    ///   - id:Prefecturesテーブルのプライマリキー
    /// - Returns:Prefecturesクラスの配列
    static func GetprefecturesByID(id: Int) -> Prefectures?{
        //プライマリキーで取得
        if let result = self.realm.object(ofType: Prefectures.self, forPrimaryKey: id){
            return result
        }
        return nil
    }
}
