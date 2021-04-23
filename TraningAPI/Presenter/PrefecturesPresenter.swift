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
protocol PrefecturesPresenterInput {
    var numberOfPrefectures: Int { get }
    var storyboard:StoryBoard { get }
    func getPrefecturesModel(updateComp: Bool)
    func getPrefectureName(index:Int) -> String
}

class PrefecturesPresenter{
    private weak var delegate: PrefecturesView?
    private var model: PrefecturesInput
    var storyboard: StoryBoard = StoryBoard()
    private let format = DateFormatter()

    
    var numberOfPrefectures: Int {
        return model.prefectures.count
    }
    
    //初期化 この時点でもうモデル知ってる必要ある？
    //それともViewから指定すればいい？？
    init(delegate: PrefecturesView, model: PrefecturesInput = PrefecturesUseCase()){
        self.delegate = delegate
        self.model = model
        
        format.dateStyle = .short
        format.timeStyle = .short
    }
}

 //    MARK: - Viewからの依頼
extension PrefecturesPresenter: PrefecturesPresenterInput{
    ///都道府県情報一覧設定
    func getPrefecturesModel(updateComp: Bool){
        guard let delegate = self.delegate else { return }
        print("Modelに情報を取りにいかせる")
        
        firstly {
            self.model.getPregectures(executionRequest: updateComp)
        }.done{ result in
            print("Modelの結果をViewに渡す")
            delegate.setList()
            if let date = result.first?.updated{
                let lastUpDate = self.format.string(from: date)
                delegate.setlastUpdate(lastUpdate: lastUpDate)
            }
        }.catch{ error in
            if let apiError:APIError = error as? APIError{
                delegate.alert(error: apiError)
            }
            
        }
    }
     ///都道府県名設定
    func getPrefectureName(index:Int) -> String{
        return self.model.prefectures[index].name
    }
}
