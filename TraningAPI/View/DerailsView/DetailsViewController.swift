//
//  DetailsView.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/16.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    // MARK: - Parameters
    @IBOutlet weak var headerView: UIView!{
        didSet{
            headerView.clipsToBounds = true
            headerView.layer.cornerRadius = 10
        }
    }
    //都道府県 名   表示ラベル
    @IBOutlet weak var titleLabel: UILabel!
    //都道府県 人口  表示ラベル
    @IBOutlet weak var populationLabel: UILabel!

    @IBOutlet weak var itemTitleView: UIView!{
        didSet{
            itemTitleView.clipsToBounds = true
            itemTitleView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var itemTitleStackView: UIStackView!{
        didSet{
            itemTitleStackView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var itemLabel: UILabel!{
        didSet{
            itemLabel.text = ConstEntity.TITLELABELTEXT
        }
    }
    @IBOutlet weak var numberLabel: UILabel!{
        didSet{
            numberLabel.text = ConstEntity.NUMBERLABELTEXT
        }
    }
    @IBOutlet weak var updatedLabel: UILabel!{
        didSet{
            updatedLabel.text = ConstEntity.UPDATEDLABELTEXT
        }
    }
    
    //各情報格納ビュー
    private var detailsFrame = StackViewFrame(axis:.vertical, alignment: .fill,  distribution: .equalSpacing, spacing: 10)
    //Prefecturesテーブルのid
    var id: Int!
    
    private var preseter: DetailsPresenterInput!
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        preseter = DetailsPresenter(delegate: self)
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(detailsFrame)
        detailsFrameLayout()
        //データベースより該当レコード情報取得
        preseter.getPrefecturesInfo(id: self.id)
    }
    
    // MARK: - 各情報格納ビューレイアウト指定
    private func detailsFrameLayout(){
        detailsFrame.translatesAutoresizingMaskIntoConstraints = false
        detailsFrame.topAnchor.constraint(equalTo: self.itemTitleView.bottomAnchor, constant: 20).isActive = true
        detailsFrame.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        detailsFrame.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
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
extension DetailsViewController: DetailsPresenterOutput{
    
    //    MARK: - 都道府県名表示
    ///
    /// - Parameters:
    ///   - name:都道府県名
    func setTitle(name: String, population: String){
        titleLabel.text = name
        populationLabel.text = DetailsConst.POPULATION + population
    }
    
    //    MARK: - 各情報表示
    ///
    /// - Parameters:
    ///   - details:Detailsクラス
    func setContent(details: [[String]]){
        details.forEach{ values in
            //各行作成
            let contentView = UIView(frame: .zero)
            detailsFrame.addArrangedSubview(contentView)
            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.heightAnchor.constraint(equalToConstant: 45).isActive = true
            contentView.layer.cornerRadius = 10
            let contentStack = StackViewFrame(axis: .horizontal, alignment: .center, distribution: .fillEqually, spacing: 0)
            contentView.addSubview(contentStack)
            contentStack.translatesAutoresizingMaskIntoConstraints = false
            contentStack.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
            contentStack.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
            
            //各列作成
            values.forEach{ value in
                let label = UILabel(frame: .zero)
                contentStack.addArrangedSubview(label)
                label.text = value
                label.adjustsFontSizeToFitWidth = true
            }
        }
    }
}
