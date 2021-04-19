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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PrefecturesPresenter(view: self)
        print("Presenterに情報取得の指示")
        presenter.GetPrefecturesModel()
    }
}
extension PrefecturesList:PrefecturesView{
    func setList() {
        print("Presenterから再描画の指示があったのでVIewを更新する")
        prefecturesListTableView.reloadData()
    }
}
extension PrefecturesList:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //遷移とPresenterから情報を渡す
        StoryBoard.Perform(id: indexPath.row + 1, to: Board.details, from: self)
    }
}
extension PrefecturesList:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfPrefectures
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PrefecturesListTableViewCell.cellIdentifer, for: indexPath) as! PrefecturesListTableViewCell
        cell.NameLabelConfigure(name: presenter.GetPrefectureName(index: indexPath.row))
        return cell
    }
    
}
