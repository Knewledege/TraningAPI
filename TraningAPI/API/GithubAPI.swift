//
//  GithubAPI.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/14.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Alamofire
import RxSwift
import RxCocoa

final class GithubAPI{

    //    MARK: - Get API　APIの値取得
    ///
    /// - Parameters:
    ///   - callback:クロージャー
    func prefecturesAPI()  -> Single<Data> {
        print("都道府県情報の一覧を取得するAPIを叩く")
        let url = "https://covid19-japan-web-api.vercel.app/api/v1/prefectures"
        // SingleはSuccessかErrorのどちらかが1回だけ通知されるObservable
        return Single.create { event in
            let request = AF.request(url).responseJSON { response in
                switch response.result{
                case .success(_):
                    guard let data = response.data else { return }
                    event(.success(data))
                    break

                case .failure(let error):
                    switch error {
                    case .sessionTaskFailed:
                        event(.failure(APIError.networkError))
                    case .invalidURL:
                        event(.failure(APIError.invalidUrlError))
                    case .responseSerializationFailed:
                        event(.failure(APIError.disableUrlError))
                        break
                   default:
                        break
                    }
                }
            }
            return Disposables.create() { request.cancel()}
        }
    }
    deinit {
        print("api deinit")
    }
}
