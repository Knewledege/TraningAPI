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
    
    var boardInit:UIViewController{
        switch self {
        case .prefecturesList:
            return PrefecturesList()
        case .details:
            return DetailsView()
        }
    }
}
final class StoryBoard{
    static func Perform(indexRow:Int, to:Board, from:UIViewController){
        let nextVC = to.boardInit
        from.present(nextVC, animated: true, completion: nil)
    }
}
