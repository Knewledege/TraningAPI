//
//  LicenceContentViewController.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/30.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import UIKit

class LicenceContentViewController: UIViewController {
    //ライセンス名
    internal var titele: String = ""
    //ライセンス内容
    internal var content: String = ""
    //ライセンス表示TextView
    private let contentView: UITextView = UITextView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = title
        contentView.text = content
        self.view.addSubview(contentView)
        // Do any additional setup after loading the view.
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
