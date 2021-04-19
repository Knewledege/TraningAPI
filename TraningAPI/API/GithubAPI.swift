//
//  GithubAPI.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/14.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Alamofire
import PromiseKit



final class GithubAPI{
    func PrefecturesAPI(callback: @escaping (Data?, Error?) -> Void) {
        print("都道府県情報の一覧を取得するAPIを叩く")
        let url = "https://covid19-japan-web-api.vercel.app/api/v1/prefectures"
        
        AF.request(url).responseJSON(completionHandler: { response in
            switch response.result{
            case .success(_):
                callback(response.data ,nil)
                break
                
            case .failure(let error):
                switch error {
                case .sessionTaskFailed:
                    callback(nil, APIError.networkError)
                case .invalidURL:
                    callback(nil, APIError.invalidUrlError)
                case .responseSerializationFailed:
                    callback(nil, APIError.disableUrlError)
                    break
               default:
                    break
                }
            }
        })
    }
}
