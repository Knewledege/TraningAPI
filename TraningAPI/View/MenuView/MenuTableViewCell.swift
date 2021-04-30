//
//  MenuTableViewCell.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/29.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    static let className = "MenuTableViewCell"
    @IBOutlet weak var menuNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        menuNameLabel.text = nil
    }
    
    internal func menuLabelConfigure(text: String){
        menuNameLabel.text = text
    }
    
    
}
