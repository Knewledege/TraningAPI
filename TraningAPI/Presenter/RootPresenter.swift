//
//  RootPresenter.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/05/07.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Foundation

protocol RootPresenterOutput:class{
    func performChild(to: Board)
    func toggleIsHidden()
}

protocol RootContainerDelegate:class{
    func setMenuID(to: Board)
    func viewWillAppear()
}

class RootPresenter{
    
    private weak var delegate: RootPresenterOutput?
    init(delegate: RootPresenterOutput, menu: MenuViewController, content: PrefecturesListViewController){
        self.delegate = delegate
        menu.delegate = self
        content.delegate = self
    }
    deinit {
        print("rootpresenter", #function)
    }
}

extension RootPresenter: RootContainerDelegate{
    ///MenuViewControllerのメニューで選択されたBoardを渡す
    func setMenuID(to: Board){
        self.delegate?.performChild(to: to)
    }
    func viewWillAppear(){
        self.delegate?.toggleIsHidden()
    }
}
