//
//  GithubAPI.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/14.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Alamofire

final class GithubAPI{
    func getAPIInformations(callback: (([Prefectures]?) -> Void)?) {
        print("都道府県情報の一覧を取得するAPIを叩く")
        let url = "https://covid19-japan-web-api.vercel.app/api/v1/prefectures"
        
        AF.request(url).responseJSON(completionHandler: { response in
            
            guard let data = response.data else {
                callback?(nil)
                return
            }
            do {
                let decodeData = try JSONDecoder().decode([Prefectures].self, from: data)
                callback?(decodeData)
            } catch {
                print("fail decode")
                callback?(nil)
            }
        })
    }
}
