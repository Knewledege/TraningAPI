//
//  StackViewFrame.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/28.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import UIKit

class StackViewFrame: UIStackView {
    
    init(axis:NSLayoutConstraint.Axis, alignment:UIStackView.Alignment,  distribution:UIStackView.Distribution, spacing:CGFloat) {
        super.init(frame: .zero)
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
