//
//  LicenceListViewController.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/28.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import UIKit

class LicenceListViewController: UIViewController {
    // ライセンスリスト
    private let licenceTableView:UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .grouped)
    private let licenceList = ConstEntity.LIBRARYTITLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = ConstEntity.LICENCETITLE
        
        // メニューリスト設定
        tableViewConfigure()
        self.view.addSubview(licenceTableView)
        // メニューリストレイアウト指定
        tableViewLayout()
        // Do any additional setup after loading the view.
    }
    /// メニューリスト設定
       private func tableViewConfigure(){
           licenceTableView.delegate = self
           licenceTableView.dataSource = self
           licenceTableView.translatesAutoresizingMaskIntoConstraints = false
           licenceTableView.register(UINib(nibName: LicenceTableViewCell.className, bundle: nil), forCellReuseIdentifier: LicenceTableViewCell.className)
           licenceTableView.backgroundColor = .white
       }
       ///メニューリスト レイアウト指定
       private func tableViewLayout(){
           licenceTableView.translatesAutoresizingMaskIntoConstraints = false
           licenceTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
           licenceTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
           licenceTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LicenceListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        StoryBoard.performNavi(id: indexPath.row, to: Board.licenceContent, from: self)
    }
}
extension LicenceListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return licenceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LicenceTableViewCell.className, for: indexPath) as? LicenceTableViewCell else { return UITableViewCell() }
        cell.licenceNameConfigure(text: licenceList[indexPath.row])
        return cell
    }
}
