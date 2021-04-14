//
//  ViewController.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/14.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import UIKit

class PrefecturesList: UIViewController{
    
    private var presenter: PrefecturesPresenterInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PrefecturesPresenter(view: self)
        print("Presenterに情報取得の指示")
        presenter.GetPrefectures()

    }
}
extension PrefecturesList:PrefecturesView{
    func setList() {
        print("Presenterから再描画の指示があったのでVIewを更新する")
    }
}

