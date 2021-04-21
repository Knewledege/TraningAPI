//
//  DetailsView.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/16.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import UIKit

class DetailsView: UIViewController {
    
    var titleLabel: UILabel!
    var detailsFrame: UIStackView!
    var id: Int!
    private var preseter: DetailsPresenterInput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preseter = DetailsPresenter(view: self)
        
        self.view.backgroundColor = .white
        
        CreateTitleLabel()
        TitleLabelLyout()
        
        CreateDetailsFrame()
        DetailsFrameLayout()
        
        preseter.GetPrefecturesInfo(id: self.id)
    }
    
    private func CreateTitleLabel(){
        titleLabel = UILabel(frame: .zero)
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        titleLabel.backgroundColor = .orange
        titleLabel.textAlignment = .center
        self.view.addSubview(titleLabel)
    }
    private func TitleLabelLyout(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    private func CreateDetailsFrame(){
        detailsFrame = CreateStackView(axis:.vertical, aligment: .fill,  distribution: .equalSpacing, spacing: 10)
        self.view.addSubview(detailsFrame)
    }
    private func DetailsFrameLayout(){
        detailsFrame.translatesAutoresizingMaskIntoConstraints = false
        detailsFrame.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 50).isActive = true
        detailsFrame.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        detailsFrame.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    private func CreateStackView(axis:NSLayoutConstraint.Axis, aligment:UIStackView.Alignment,  distribution:UIStackView.Distribution, spacing:CGFloat) -> UIStackView {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = axis
        stackView.alignment = aligment
        stackView.distribution = distribution
        stackView.spacing = spacing
        return stackView
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
extension DetailsView: DetailsPresenterOutput{
    func SetTitle(name: String){
        titleLabel.text = name
    }
    func SetContent(details: [[String]]){
        details.forEach{ values in
            let content = CreateStackView(axis: .horizontal, aligment: .fill, distribution: .fillEqually, spacing: 0)
            values.forEach{ value in
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                label.text = value
                label.adjustsFontSizeToFitWidth = true
                content.addArrangedSubview(label)
            }
            detailsFrame.addArrangedSubview(content)
        }
        
    }
}
