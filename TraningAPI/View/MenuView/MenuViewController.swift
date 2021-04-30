//
//  MenuViewController.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/28.
//  Copyright © 2021 k-takahashi. All rights reserved.
//
import UIKit

class MenuViewController: UIViewController {
    // サイドメニュー
    private let menuView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height))
    // 戻るボタン
    private let buckViewButton: UIButton = UIButton(frame: CGRect(x: 10, y: 35, width: 70, height: 70))
    // メニューリスト
    private let menuTableView:UITableView = UITableView(frame: .zero, style: .grouped)
    // メニュー名
    private let menuList: [String] = MenuListEntity.MENULIST
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // サイドメニュー設定
        menuView.layer.backgroundColor = UIColor.white.cgColor
        self.view.addSubview(menuView)
        
        //戻るボタン設定
        backViewButtonConfigure()
        menuView.addSubview(buckViewButton)
        
        // メニューリスト設定
        tableViewConfigure()
        menuView.addSubview(menuTableView)
        // メニューリストレイアウト指定
        tableViewLayout()
        
        // 移動位置
        let menuPosition: CGPoint = self.menuView.layer.position
        // 初期位置
        self.menuView.layer.position.x = -self.menuView.frame.width
        // アニメーション開始
        animateMenuView(position: menuPosition.x, dismiss: false)

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
        self.menuTableView.translatesAutoresizingMaskIntoConstraints = false
        self.menuTableView.topAnchor.constraint(equalTo: self.buckViewButton.bottomAnchor, constant: 10).isActive = true
        self.menuTableView.widthAnchor.constraint(equalTo: self.menuView.widthAnchor).isActive = true
        self.menuTableView.bottomAnchor.constraint(equalTo: self.menuView.bottomAnchor).isActive = true
    }
    /// 戻るボタン設定
    private func backViewButtonConfigure(){
        buckViewButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        buckViewButton.tintColor = .black
        buckViewButton.addTarget(self, action: #selector(viewDismiss), for: .touchUpInside)
    }
    /// サイドメニュー開閉のアニメーション
    private func animateMenuView(position: CGFloat, dismiss: Bool){
        // 表示アニメーション
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.menuView.layer.position.x = position
        },
            completion: { bool in
                if dismiss{
                    self.dismiss(animated: false, completion: nil)
                }
        })
    }

    /// 戻るボタン押下時
    @objc func viewDismiss(){
        animateMenuView(position: -self.menuView.frame.width, dismiss: true)
    }

    /// サイドメニュー外押下時
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        if touches.first != nil{
            viewDismiss()
        }
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
            StoryBoard.performNavi(id: 0, to: board, from: self)
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
