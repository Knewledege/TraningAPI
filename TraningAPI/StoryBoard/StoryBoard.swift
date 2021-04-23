//
//  StoryBoard.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/16.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import UIKit
enum Board {

    case prefecturesList
    case details
    
    func boardInit(id: Int) -> UIViewController{
        switch self {
        case .prefecturesList:
            let nextVC = PrefecturesListViewController()
            return nextVC
        case .details:
            let nextVC = DetailsViewController()
            nextVC.id = id
            return nextVC
        }
    }
}

final class StoryBoard{
    //    MARK: - Screen Transition　画面遷移
    ///
    /// - Parameters:
    ///   - id :Prefecturesテーブルのid
    ///   - to:遷移先のViewController
    ///   - from:遷移元のViewController
    static func perform(id:Int, to:Board, from:UIViewController){
        let nextVC = to.boardInit(id: id)
        from.present(nextVC, animated: true, completion: nil)
    }
}
