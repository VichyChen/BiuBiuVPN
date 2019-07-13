//
//  DVServerListCell.swift
//  DajieVPN
//
//  Created by mac on 2017/4/18.
//  Copyright © 2017年 DajieVPN. All rights reserved.
//

import UIKit

class DVServerListCell: UITableViewCell {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        flagImageView.layer.shadowOpacity = 1
        flagImageView.layer.shadowColor = UIColor.lightGray.cgColor
        flagImageView.layer.shadowRadius = 1
        flagImageView.layer.shadowOffset = CGSize.init(width: 1, height: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
