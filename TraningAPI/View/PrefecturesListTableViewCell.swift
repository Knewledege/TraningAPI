//
//  PrefecturesListTableViewCell.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/15.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import UIKit

class PrefecturesListTableViewCell: UITableViewCell {
    
    static var cellIdentifer = "PrefecturesListTableViewCell"
    
    //都道府県名表示
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func prepareForReuse() {
        nameLabel.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func nameLabelConfigure(name: String){
        nameLabel.text = name
    }
    
}
