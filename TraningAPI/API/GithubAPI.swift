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
    
    //    MARK: - Get API　APIの値取得
    ///
    /// - Parameters:
    ///   - callback:クロージャー
    func PrefecturesAPI()  -> Promise<Data> {
        let (promise, resolver) = Promise<Data>.pending()
        print("都道府県情報の一覧を取得するAPIを叩く")
        let url = "https://covid19-japan-web-api.vercel.app/api/v1/prefectures"
        
        AF.request(url).responseJSON(completionHandler: { response in
            switch response.result{
            case .success(_):
                guard let data = response.data else { return }
                resolver.fulfill(data)
                break
                
            case .failure(let error):
                switch error {
                case .sessionTaskFailed:
                    resolver.resolve(nil, APIError.networkError)
                case .invalidURL:
                    resolver.resolve(nil, APIError.invalidUrlError)
                case .responseSerializationFailed:
                    resolver.resolve(nil, APIError.disableUrlError)
                    break
               default:
                    break
                }
            }
        })
        return promise
    }
    deinit {
        print("api deinit")
    }
}
