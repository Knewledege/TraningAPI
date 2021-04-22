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
    func setList()
    func setlastUpdate(lastUpdate:String)
    func alert(error: APIError)
}
protocol PrefecturesPresenterInput: class {
    var numberOfPrefectures: Int { get }
    var storyboard:StoryBoard { get }
    func getPrefecturesModel(updateComp: Bool)
    func getPrefectureName(index:Int) -> String
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
    func getPrefecturesModel(updateComp: Bool){
        print("Modelに情報を取りにいかせる")
        
        firstly {
            self.model.getPregectures(executionRequest: updateComp)
        }.done{ result in
            print("Modelの結果をViewに渡す")
            self.view.setList()
            if let date = result.first?.updated{
                let lastUpDate = self.format.string(from: date)
                self.view.setlastUpdate(lastUpdate: lastUpDate)
            }
        }.catch{ error in
            if let apiError:APIError = error as? APIError{
                self.view.alert(error: apiError)
            }
            
        }
    }
     ///都道府県名設定
    func getPrefectureName(index:Int) -> String{
        return self.model.prefectures[index].name_ja
    }
}
