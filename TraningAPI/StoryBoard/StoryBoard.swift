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
    case menuView
    case licenceList
    case licenceContent
    
    var identifer: String{
        switch self {
        case .prefecturesList: return "PrefecturesListViewController"
        case .details:         return "DetailsViewController"
        case .menuView:        return "MenuViewController"
        case .licenceList:     return "LicenceListViewController"
        case .licenceContent:  return "LicenceContentViewController"
        }
    }
    
    func boardInit(id: Int) -> UIViewController?{
        switch self {
        case .prefecturesList:
            let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: self.identifer) as? PrefecturesListViewController
            return nextVC
        case .details:
            let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: self.identifer) as? DetailsViewController
            nextVC?.id = id
            return nextVC
        case .menuView:
            let nextVC = MenuViewController()
            return nextVC
        case .licenceList:
            let nextVC = LicenceListViewController()
            return nextVC
        case .licenceContent:
            let nextVC = LicenceContentViewController()
            nextVC.title = ConstEntity.LIBRARYTITLE[id]
            nextVC.content = ConstEntity.LIBRARYCONTENT[id]
            return nextVC
        }
    }
}

final class StoryBoard{
    //    MARK: - Screen Transition　画面遷移
    /// - Parameters:
    ///   - id :Prefecturesテーブルのid
    ///   - to:遷移先のViewController
    ///   - from:遷移元のViewController
    ///Show遷移
    static func perform(id:Int, to:Board, from:UIViewController){
        if let nextVC = to.boardInit(id: id){
            from.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    deinit {
          print("storyboard", #function)
      }
}
