//
//  RootViewController.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/05/06.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    //メニュー表示位置
    private var menuPosition: CGPoint?
    //メニュー非表示位置
    private var menuHiddenPosition: CGFloat?
    //メニュースライドボタン
    private lazy var menuToggle: UIButton = {
                                        //右スライド用x:UIScreen.main.bounds.maxX-80
        let button = UIButton(frame: CGRect(x: 20, y: 44, width: 56, height: 38))
        button.setImage(UIImage(systemName: "text.justify"), for: .normal)
        button.setImage(UIImage(systemName: "xmark"), for: .selected)
//        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(menuOpen), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    ///メニュー開閉指示
    @objc private func menuOpen(_ sender: UIButton){
        var xPosition:CGFloat = 0
        //開いていたら
        if sender.isSelected {
            xPosition = self.menuHiddenPosition ?? 0
        }else{
        //閉じていたら
            if let x = menuPosition?.x {
                xPosition = x
            }
        }
        //アニメーションかいし
        animateMenuView(position: xPosition)
        //ボタンselecet反転
        sender.isSelected = !sender.isSelected
    }
    
    
    /// メニュー開閉のアニメーション
    private func animateMenuView(position: CGFloat){
        // 表示アニメーション
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.menuView.layer.position.x = position
        },
            completion: { bool in
        })
    }
    
    //メニュー表示ビュー
    private var menuView: UIView = UIView(frame: CGRect(x: 0,//右スライド用 (UIScreen.main.bounds.width / 3)
                                                        y: 0,
                                                        width: (UIScreen.main.bounds.width / 3) * 2,
                                                        height: UIScreen.main.bounds.height))
    //コンテンツ表示ビュー
    private var contentView: UIView = UIView(frame: CGRect(x: UIScreen.main.bounds.minX, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
           //メニューに表示するViewController
        if let menu = Board.menuView.boardInit(id: 0) as? MenuViewController,
            //contentViewに表示する最初のViewController
            let firstContentViewController = Board.prefecturesList.boardInit(id: 0) as? PrefecturesListViewController {
            //contentViewにNavigationViewControllerを設定
            let navi = UINavigationController(rootViewController: firstContentViewController)
            //ビューの大きさ指定
            contentView = navi.view
            menu.view.frame = menuView.frame
            menuView = menu.view
            
            self.addChild(navi)
            self.addChild(menu)
            
            self.view.addSubview(contentView)
            self.view.addSubview(menuView)
            //presenter登録
            RootPresenter(delegate: self, menu: menu, content: firstContentViewController)
            
            //右スライド用
//            menuHiddenPosition = self.menuView.frame.width*2
            //左スライド用
            menuHiddenPosition = -self.menuView.frame.width
            
        }
        //メニュー開閉ボタンの追加
        self.view.addSubview(menuToggle)
//
//        self.menuView.translatesAutoresizingMaskIntoConstraints = false
//        self.menuView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//        self.menuView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//        self.menuView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//        self.menuView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
//        self.menuToggle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
//        self.menuToggle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
//        self.menuToggle.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        self.menuToggle.widthAnchor.constraint(equalToConstant: 56).isActive = true
        //メニュー表示位置取得
        menuPosition =  self.menuView.layer.position
        // 初期位置設定
        self.menuView.layer.position.x = menuHiddenPosition ?? 0
        //スワイプでメニュー閉じる
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(Swipe))
        swipe.direction = .left
        self.view.addGestureRecognizer(swipe)
    }
    ///スワイプジェスチャーの指示
    @objc private func Swipe(_ sender:UIGestureRecognizer){
        if menuToggle.isSelected{
            animateMenuView(position: self.menuHiddenPosition ?? 0)
            menuToggle.isSelected = false
        }
    }
    @objc func Tap(_ sender:UIGestureRecognizer){
        print("呼ばれてるよ")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

    
    
    deinit {
        print(#function)
    }
}
extension RootViewController: RootPresenterOutput{
    
    func performChild(to: Board){
        
        //メニューで選択されたViewController取得
        if let nextVC = to.boardInit(id: 0){
            self.children.first?.children.first?.navigationController?.pushViewController(nextVC, animated: true)
            //メニュー閉じるアニメーション
            animateMenuView(position: self.menuHiddenPosition ?? 0)
            menuToggle.isHidden = true
            menuToggle.isSelected = false
        }
        
    }
    
    func toggleIsHidden(){
        menuToggle.isHidden = !menuToggle.isHidden
    }
}
