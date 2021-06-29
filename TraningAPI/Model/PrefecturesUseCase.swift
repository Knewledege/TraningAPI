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
import RxSwift
import RxCocoa


protocol PrefecturesInput{
    func getPregectures(executionRequest:Bool) -> Promise<[Prefectures]>
    func getDetails(id: Int)
    var prefectures: [Prefectures] { get }
    var details: Prefectures! { get }
}

class PrefecturesUseCase {
    internal var prefectures: [Prefectures] = []
    internal var details: Prefectures!
    private let api:GithubAPI!
//    private let realmDB:RealmDB!
    private let sqLite: SQLite!
    private let reachability:Reachability!
    private let disposeBag = DisposeBag()
   
//    init(api: GithubAPI = GithubAPI(), localDB: RealmDB = RealmDB()){
    init(api: GithubAPI = GithubAPI(), localDB: SQLite = SQLite()){
        self.api = api
        self.sqLite = localDB
        
         do{
            reachability = try Reachability()
         }catch{
            reachability = nil
         }
    }
    deinit {
        print("model deinit")
    }
}


extension PrefecturesUseCase:PrefecturesInput{
    //    MARK: - 都道府県情報一覧取得
    /// - Parameters:
    ///   -executionRequest:  TRUE:DBから取得  FALSE:APIから取得　呼び出し元の依頼
    func getPregectures(executionRequest:Bool) -> Promise<[Prefectures]>{
  
        let (promise, resolver) = Promise<[Prefectures]>.pending()
        
        //DB全取得
//        let dbResult = realmDB.getPrefecturesByRealmDB()
        let dbResult = sqLite.fetchPrefectures()
        
        //DBにデータがある場合
        if let result = dbResult{
            self.prefectures = result
            
            //圏外ならDBの値を返す
            if reachability.connection == .unavailable{
                resolver.fulfill(self.prefectures)
                return promise
            }
            
            //圏内かつ最終更新時間が1分以内でもDBの値を返す
            if getLastUpdate(updated: result.first?.updated){
                resolver.fulfill(self.prefectures)
                return promise
            }
        }
        
        self.api.prefecturesAPI().subscribe(onSuccess: { [weak self] data in
            guard let self = self else { return }
            DecodePrefectures.jsonDecode(data: data).subscribe(onSuccess: { [weak self] result in
                self?.prefectures = result
                self?.sqLite.insertPrefectures(prefectures: result)
                resolver.fulfill(result)
            }, onFailure: { error in
                 resolver.reject(error)
            }).disposed(by:self.disposeBag )
        }, onFailure: { error in
             resolver.reject(error)
        }).disposed(by: disposeBag )
        return promise
    }
    
    //    MARK: - 最終更新時間比較
    private func getLastUpdate(updated: Date?) -> Bool{
        if let lastUpdate = updated{
            //分単位で比較
            let difference = Calendar.current.dateComponents([.minute], from: lastUpdate, to: Date()).minute ?? 0
            if difference > 1{
                return false
            }
        }else{
            return false
        }
        return true
    }
    //    MARK: - 該当レコードをデータベースより取得
    internal func getDetails(id: Int){
//        self.details = realmDB.getprefecturesByID(id: id)
        self.details = sqLite.getprefecturesByID(id: id)
    }
    
}
