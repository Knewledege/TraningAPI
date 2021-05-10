//
//  ViewController.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/14.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import UIKit

class PrefecturesListViewController: UIViewController{
    
    private var presenter: PrefecturesPresenterInput!
    weak var delegate: RootContainerDelegate?
    
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
            reloadButton.addTarget(self,action: #selector(reloadTableView), for: .touchUpInside)
            reloadButton.isEnabled = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = PrefecturesPresenter(delegate: self)
        print("Presenterに情報取得の指示")
        presenter.getPrefecturesModel(updateComp: true)
    }
    deinit {
        print("prefectureslist", #function)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print(#function)
        self.navigationController?.navigationBar.isHidden = true
        self.delegate?.viewWillAppear()
        
        print(self.parent?.parent)
    }
    @objc func reloadTableView(){
        presenter.getPrefecturesModel(updateComp: false)
    }
}
extension PrefecturesListViewController:PrefecturesView{
    func setList() {
        print("Presenterから再描画の指示があったのでVIewを更新する")
        prefecturesListTableView.reloadData()
    }
    func setlastUpdate(lastUpdate:String){
        lastUpdateLabel.text = lastUpdate
        reloadButton.isEnabled = true
    }
    func alert(error: APIError){
        let alert = UIAlertController(title: "エラーが発生しました", message: error.massegeDescription, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{
            (action: UIAlertAction) -> Void in
            self.presenter.getPrefecturesModel(updateComp: false)
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
extension PrefecturesListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //遷移とPresenterから情報を渡す
        /*
         Viewではあくまでも依頼を流すだけなら、Presenterに書くべき処理？
         */
        if let indexRow = RegionModel.Region(rawValue: indexPath.section)?.prefecturesID[indexPath.row]{
            StoryBoard.perform(id: indexRow+1, to: Board.details, from: self)
            self.delegate?.viewWillAppear()
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UITableViewHeaderFooterView()
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(touchHeader))
        header.addGestureRecognizer(gesture)
        header.tag = section
        return header
    }
    @objc func touchHeader(_ sender: UITapGestureRecognizer) {
        guard let section = sender.view?.tag else { return }
        RegionModel.nameIsHidden[section] = !RegionModel.nameIsHidden[section]
        prefecturesListTableView.beginUpdates()
        prefecturesListTableView.reloadSections([section], with: .automatic)
        prefecturesListTableView.endUpdates()
    }
}
extension PrefecturesListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let region = RegionModel.Region(rawValue: section) else { return "" }
        return region.name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return RegionModel.regions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let region = RegionModel.Region(rawValue: section) else { return 0 }
       
        if RegionModel.nameIsHidden[section] {
            return 0
        }else{
            return region.prefecturesID.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PrefecturesListTableViewCell.cellIdentifer, for: indexPath) as? PrefecturesListTableViewCell else{
            return UITableViewCell()
        }
        if let indexRow = RegionModel.Region(rawValue: indexPath.section)?.prefecturesID[indexPath.row]{
            cell.nameLabelConfigure(name: presenter.getPrefectureName(index: indexRow ))
            cell.infectedConfigure(number: presenter.getCasesNumber(index: indexRow))
        }
        return cell
    }
    
}
