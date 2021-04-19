//
//  InfectedUser.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/14.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Foundation
import PromiseKit

protocol PrefecturesInput{
    func GetPregectures(completion: @escaping ([Prefectures]?) -> Void)
    var prefectures: [Prefectures]? { get }
}


class PrefecturesModel:PrefecturesInput{
    
    internal var prefectures: [Prefectures]? = []
    private let api:GithubAPI
    
    init(api: GithubAPI = GithubAPI()){
        self.api = api
    }
    
    //都道府県情報一覧取得
    func GetPregectures(completion: @escaping ([Prefectures]?) -> Void){
        //API処理
        self.api.PrefecturesAPI(callback: { (result,error) in
            print("結果をコールバックで返す")
            if let error = error{
                print("エラー内容：",error)

            }
            if let result = result{
                self.prefectures = DecodePrefectures(data: result).prefectures
                completion(self.prefectures)
            }
        })
    }
    
}
