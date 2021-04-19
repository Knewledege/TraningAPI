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
    
    func BoardInit(id: Int) -> UIViewController{
        switch self {
        case .prefecturesList:
            let nextVC = PrefecturesList()
            return nextVC
        case .details:
            let nextVC = DetailsView()
            nextVC.id = id
            return nextVC
        }
    }
}
final class StoryBoard{
    static func Perform(id:Int, to:Board, from:UIViewController){
        let nextVC = to.BoardInit(id: id)
        from.present(nextVC, animated: true, completion: nil)
    }
}
