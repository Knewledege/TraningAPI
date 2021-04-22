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

    @IBOutlet weak var prefecturesListTableView: UITableView!{
        didSet{
            prefecturesListTableView.delegate = self
            prefecturesListTableView.dataSource = self
            prefecturesListTableView.register(UINib(nibName: PrefecturesListTableViewCell.cellIdentifer, bundle: nil), forCellReuseIdentifier: PrefecturesListTableViewCell.cellIdentifer)
        }
    }
    
    @IBOutlet weak var lastUpdateLabel: UILabel!
    @IBOutlet weak var reloadButton: UIButton!{
        didSet{
            reloadButton.addTarget(self,action: #selector(ReloadTableView), for: .touchUpInside)
            reloadButton.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PrefecturesPresenter(view: self)
        print("Presenterに情報取得の指示")
        presenter.GetPrefecturesModel(updateComp: true)
    }
    
    @objc func ReloadTableView(){
        presenter.GetPrefecturesModel(updateComp: false)
    }
}
extension PrefecturesList:PrefecturesView{
    func SetList() {
        print("Presenterから再描画の指示があったのでVIewを更新する")
        prefecturesListTableView.reloadData()
    }
    func SetlastUpdate(lastUpdate:String){
        lastUpdateLabel.text = lastUpdate
        reloadButton.isEnabled = true
    }
    func Alert(error: APIError){
        let Alert = UIAlertController(title: "エラーが発生しました", message: error.massegeDescription, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{
            (action: UIAlertAction) -> Void in
            self.presenter.GetPrefecturesModel(updateComp: false)
        })
        Alert.addAction(okAction)
        self.present(Alert, animated: true, completion: nil)
    }
}
extension PrefecturesList:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //遷移とPresenterから情報を渡す
        /*
         Viewではあくまでも依頼を流すだけなら、Presenterに書くべき処理？
         */
        StoryBoard.Perform(id: indexPath.row + 1, to: Board.details, from: self)
    }
}
extension PrefecturesList:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfPrefectures
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PrefecturesListTableViewCell.cellIdentifer, for: indexPath) as? PrefecturesListTableViewCell else{
            return UITableViewCell()
        }
        cell.NameLabelConfigure(name: presenter.GetPrefectureName(index: indexPath.row))
        return cell
    }
    
}
