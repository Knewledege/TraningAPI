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
    var numberOfPrefectures: Int { get }
    var storyboard:StoryBoard { get }
    func GetPrefecturesModel()
    func GetPrefectureName(index:Int) -> String
}

class PrefecturesPresenter{
    private weak var view: PrefecturesView!
    private var model: PrefecturesInput
    var storyboard: StoryBoard = StoryBoard()
    
    var numberOfPrefectures: Int {
        return model.prefectures!.count
    }
    
    //初期化 この時点でもうモデル知ってる必要ある？
    //それともViewから指定すればいい？？
    init(view: PrefecturesView, model: PrefecturesInput = PrefecturesModel()){
        self.view = view
        self.model = model
    }
    
}
extension PrefecturesPresenter: PrefecturesPresenterInput{
    ///都道府県情報一覧取得
    func GetPrefecturesModel(){
        print("Modelに情報を取りにいかせる")
        self.model.GetPregectures(completion: { (prefectures:[Prefectures]?) in
            print("Modelの結果をViewに渡す")
            self.view.setList()
        })
    }
    
    func GetPrefectureName(index:Int) -> String{
        return self.model.prefectures?[index].name_ja ?? "取得できませんでした"
    }
}
