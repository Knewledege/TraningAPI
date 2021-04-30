//
//  LicenceTableViewCell.swift
//  TraningAPI
//
//  Created by 高橋慧 on 2021/04/30.
//  Copyright © 2021 k-takahashi. All rights reserved.
//

import UIKit

class LicenceTableViewCell: UITableViewCell {
    static let className = "LicenceTableViewCell"
    @IBOutlet weak var licenceNameLabel: UILabel!
    
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
        licenceNameLabel.text = nil
    }
    
    internal func licenceNameConfigure(text: String){
        licenceNameLabel.text = text
    }
    
}
