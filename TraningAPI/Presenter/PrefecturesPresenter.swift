//
//  PrefecturePresenter.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/14.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Foundation

protocol PrefecturesView: class {
//    func setList(prefecturs: [Prefectures])
    func setList()
}
protocol PrefecturesPresenterInput: class {
    func GetPrefectures()
}

class PrefecturesPresenter{
    private weak var view: PrefecturesView!
    private var model: PrefecturesInput
    
    
    //初期化 この時点でもうモデル知ってる必要ある？
    //それともViewから指定すればいい？？
    init(view: PrefecturesView, model: PrefecturesInput = PrefecturesModel()){
        self.view = view
        self.model = model
    }
    

    
}
extension PrefecturesPresenter:PrefecturesPresenterInput{
    //都道府県情報一覧取得
    func GetPrefectures(){
        print("Modelに情報を取りにいかせる")
        self.model.Get()
        print("Modelの結果をViewに渡す")
        self.view.setList()
    }
}
