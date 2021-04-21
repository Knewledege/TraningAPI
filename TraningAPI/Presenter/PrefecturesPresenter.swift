//
//  PrefecturePresenter.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/14.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import Foundation

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
extension PrefecturesPresenter: PrefecturesPresenterInput{
    ///都道府県情報一覧取得
    func GetPrefecturesModel(updateComp: Bool){
        print("Modelに情報を取りにいかせる")
        self.model.GetPregectures(updateComp: updateComp, completion: { result in
            switch result {
            case .success(let prefectures):
                print("Modelの結果をViewに渡す")
                self.view.SetList()
                let lastUpDate = self.format.string(from: prefectures.first!.updated)
                self.view.SetlastUpdate(lastUpdate: lastUpDate)
                break
            case .failure(let error):
                self.view.Alert(error: error)
                break
            }
 
        })
    }
    
    func GetPrefectureName(index:Int) -> String{
        return self.model.prefectures[index].name_ja
    }
}
