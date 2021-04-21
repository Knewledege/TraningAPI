//
//  DetailsPresenter.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/19.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Foundation
protocol  DetailsPresenterInput:class{
    func GetPrefecturesInfo(id: Int)
}
protocol  DetailsPresenterOutput:class {
    func SetTitle(name: String)
    func SetContent(details: [[String]])
}

class DetailsPresenter{
    
    private weak var view: DetailsPresenterOutput!
    private var model: PrefecturesInput
    init(view: DetailsPresenterOutput, model: PrefecturesInput = PrefecturesModel()) {
        self.view = view
        self.model = model
    }
}
//    MARK: - Viewからの依頼
extension DetailsPresenter: DetailsPresenterInput{
    ///感染者数詳細表示
    func GetPrefecturesInfo(id: Int){
        model.GetDetails(id: id)
        let details = Details.DetailsToArray(prefectures: self.model.details)
        self.view.SetContent(details: details)
        self.view.SetTitle(name: self.model.details.name_ja)
    }
}
