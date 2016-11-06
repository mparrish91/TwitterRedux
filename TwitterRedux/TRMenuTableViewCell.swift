//
//  TFMenuTableViewCell.swift
//  TwitterRedux
//
//  Created by parry on 11/5/16.
//  Copyright © 2016 parry. All rights reserved.
//

import UIKit

class TRMenuTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
