//
//  TFMenuHeaderTableViewCell.swift
//  TwitterRedux
//
//  Created by parry on 11/5/16.
//  Copyright © 2016 parry. All rights reserved.
//

import UIKit

class TFMenuHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
