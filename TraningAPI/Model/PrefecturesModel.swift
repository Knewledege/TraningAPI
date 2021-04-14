//
//  InfectedUser.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/14.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Foundation

protocol PrefecturesInput{
    func Get()
}


class PrefecturesModel:PrefecturesInput{
    private let api:GithubAPI
    
    init(api: GithubAPI = GithubAPI()){
        self.api = api
    }
    
    //都道府県情報一覧取得
    func Get(){
        print("Presenterから取得に依頼が来たのでAPIを叩く")
        //API処理
        self.api.getAPIInformations(callback: { result in
          print("結果をコールバックで返す")
        })
    }
    
}
