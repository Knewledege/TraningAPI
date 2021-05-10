//
//  MenuViewController.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/28.
//  Copyright © 2021 k-takahashi. All rights reserved.
//
import UIKit

class MenuViewController: UIViewController {
    
    var delegate: RootContainerDelegate?
    // サイドメニュー
//    private let leftMenuView: UIView = UIView(frame: CGRect(x: UIScreen.main.bounds.minX, y: 0, width: (UIScreen.main.bounds.width / 3) * 2, height: UIScreen.main.bounds.height))

    // メニューリスト
    private let menuTableView:UITableView = UITableView(frame: .zero, style: .grouped)
    // メニュー名
    private let menuList: [String] = MenuListEntity.MENULIST
    
    weak var story: StoryBoard?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // サイドメニュー設定
        self.view.layer.backgroundColor = UIColor.white.cgColor
//        self.view.addSubview(leftMenuView)
//        self.view.layer.backgroundColor = UIColor.red.cgColor
        
//        leftMenuView.translatesAutoresizingMaskIntoConstraints = false
        
        // メニューリスト設定
        tableViewConfigure()
//        leftMenuView.addSubview(menuTableView)
        self.view.addSubview(menuTableView)
       
        // メニューリストレイアウト指定
        tableViewLayout()
        // 移動位置
//        let menuPosition: CGPoint = self.leftMenuView.layer.position
        // 初期位置
//        self.leftMenuView.layer.position.x = -self.leftMenuView.frame.width
        // アニメーション開始
//        animateMenuView(position: menuPosition.x, dismiss: false)

    }
    /// メニューリスト設定
    private func tableViewConfigure(){
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        menuTableView.register(UINib(nibName: MenuTableViewCell.className, bundle: nil), forCellReuseIdentifier: MenuTableViewCell.className)
        menuTableView.backgroundColor = .white
    }
    ///メニューリスト レイアウト指定
    private func tableViewLayout(){
        self.menuTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
        self.menuTableView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.menuTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
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

extension MenuViewController: UITableViewDelegate{
    ///高さ設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 工事中が存在するため
        if let board = MenuListEntity.MENULISTIDENTIFER[indexPath.row]{
            self.delegate?.setMenuID(to: board)
        }
    }
}
extension MenuViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.className, for: indexPath) as? MenuTableViewCell else { return UITableViewCell() }
        cell.menuLabelConfigure(text: menuList[indexPath.row])
        return cell
    }
}
