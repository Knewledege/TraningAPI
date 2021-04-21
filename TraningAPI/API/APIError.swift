//
//  APIError.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/15.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Foundation
enum APIError:Error{
    
    //ネットラーク接続ないとき
    case networkError
    //URLが設定されていないとき
    case invalidUrlError
    //URLが正しくないとき
    case disableUrlError
    //Jsonが復号できなかったとき
    case decodeError
    
    var massegeDescription: String {
        switch self {
        case .networkError:
            return "ネットワーク接続に問題があります"
        case .invalidUrlError:
            return "URLを設定してください"
        case .disableUrlError:
            return "設定されたURLに誤りがあります"
        case .decodeError:
            return "JSON情報を復号できませんでした"
        }
    }
}
