//
//  PrefecturePresenter.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/14.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Foundation
import PromiseKit

protocol PrefecturesView: class {
    func SetList()
    func SetlastUpdate(lastUpdate:String)
    func Alert(error: APIError)
}
protocol PrefecturesPresenterInput: class {
    var numberOfPrefectures: Int { get }
    var storyboard:StoryBoard { get }
    func GetPrefecturesModel(updateComp: Bool)
    func GetPrefectureName(index:Int) -> String
}

class PrefecturesPresenter{
    private weak var view: PrefecturesView!
    private var model: PrefecturesInput
    var storyboard: StoryBoard = StoryBoard()
    private let format = DateFormatter()

    
    var numberOfPrefectures: Int {
        return model.prefectures.count
    }
    
    //初期化 この時点でもうモデル知ってる必要ある？
    //それともViewから指定すればいい？？
    init(view: PrefecturesView, model: PrefecturesInput = PrefecturesModel()){
        self.view = view
        self.model = model
        
        format.dateStyle = .short
        format.timeStyle = .short
    }
}

 //    MARK: - Viewからの依頼
extension PrefecturesPresenter: PrefecturesPresenterInput{
    ///都道府県情報一覧設定
    func GetPrefecturesModel(updateComp: Bool){
        print("Modelに情報を取りにいかせる")
        
        firstly {
            self.model.GetPregectures(executionRequest: updateComp)
        }.done{ result in
            print("Modelの結果をViewに渡す")
            self.view.SetList()
            if let date = result.first?.updated{
                let lastUpDate = self.format.string(from: date)
                self.view.SetlastUpdate(lastUpdate: lastUpDate)
            }
        }.catch{ error in
            if let apiError:APIError = error as? APIError{
                self.view.Alert(error: apiError)
            }
            
        }
    }
     ///都道府県名設定
    func GetPrefectureName(index:Int) -> String{
        return self.model.prefectures[index].name_ja
    }
}
