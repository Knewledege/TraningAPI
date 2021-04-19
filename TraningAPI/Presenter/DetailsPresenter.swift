//
//  DetailsPresenter.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/19.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Foundation
protocol  DetailsPresenterInput:class{
    func GetDetails(id: Int)
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
extension DetailsPresenter: DetailsPresenterInput{
    
    func GetDetails(id: Int){
        
        model.GetprefecturesByID(id: id)
        model.GetPregectures(completion: { prefectures in
            let details = Details.DetailsToArray(prefectures: (self.model.prefectures?.first!)!)
            self.view.SetContent(details: details)
            self.view.SetTitle(name: (self.model.prefectures?.first!.name_ja)!)
        })

    }
}
