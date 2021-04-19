//
//  DetailsView.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/16.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import UIKit

class DetailsView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    private func CreateDetailsFrame(){
        let detailsFrame = CreateStackView(axis:.vertical, aligment: .center,  distribution: .equalSpacing, spacing: 10)
        
    }
    private func CreateStackView(axis:NSLayoutConstraint.Axis, aligment:UIStackView.Alignment,  distribution:UIStackView.Distribution, spacing:CGFloat) -> UIStackView {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
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
