////
////  SQLite.swift
////  TraningAPI
////
////  Created by 高橋慧 on 2021/04/30.
////  Copyright © 2021 k-takahashi. All rights reserved.
////
//
//import Foundation
//import GRDB
//class SQLite {
//    private let fileManager = FileManager.default
//    private let filePath = NSHomeDirectory() + "/Documents/" + "SQLite.db"
//    private var queue : DatabaseQueue?
//    
//    init() {
//        print(filePath)
//        self.createDatabase()
//    }
//
//    /// データベースファイル取込
//    func dataBaseConfigure(){
//        do {
//            queue = try DatabaseQueue(path: filePath)
//        } catch {
//        }
//    }
//
//    /// データベース生成
//    private func createDatabase() {
//        let exists = fileManager.fileExists(atPath: filePath)
//        dataBaseConfigure()
//        if !exists {
//            do{
//                try queue?.inDatabase{ (db) in
//                    try db.create(table: Prefectures.databaseTableName) { (t) in
//                        t.column("id", .integer).primaryKey(onConflict: .ignore, autoincrement: true)
//                        t.column(Prefectures.CodingKeys.name.rawValue, .text).notNull()
//                        t.column("population", .integer).notNull()
//                        t.column("cases", .integer).notNull()
//                        t.column("deaths", .integer).notNull()
//                        t.column("pcr", .integer).notNull()
//                        t.column("hospitalize", .integer).notNull()
//                        t.column("severe", .integer).notNull()
//                        t.column("discharge", .integer).notNull()
//                        t.column(Prefectures.CodingKeys.symptomConfirming.rawValue, .integer).notNull()
//                        t.column(Prefectures.CodingKeys.lastUpdated.rawValue, .date).notNull()
//                        print("登録")
//                    }
//                }
//            } catch {
//            }
//        }
//    }
//    
//    internal func insertPrefectures(prefectures:[Prefectures]){
////        print(prefectures)
//        do{
//            try queue?.inDatabase { (db) in
//                prefectures.forEach{ data in
//                    do{
//                        try data.save(db)
//
//                    }catch let error{
//                        print(error)
//                    }
//                }
//            }
//        } catch {
//        }
//    }
//    internal func fetchPrefectures() -> [Prefectures]?{
//        var result: [Prefectures]?
//        do{
//            try queue?.inDatabase { (db) in
//                result = try Prefectures.fetchAll(db)
//            }
//        }catch let error{
//            print(error)
//            return nil
//        }
//        return result
//    }
//    internal func getprefecturesByID(id: Int) -> Prefectures?{
//        var result: Prefectures?
//        do{
//            try queue?.inDatabase { (db) in
//                result = try Prefectures.fetchOne(db, key: id)
//            }
//        }catch let error{
//            print(error)
//            return nil
//        }
//        return result
//    }
//}
