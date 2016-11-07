//
//  TRTweetTableViewCell.swift
//  TwitterRedux
//
//  Created by parry on 11/5/16.
//  Copyright © 2016 parry. All rights reserved.
//

import UIKit

class TRTweetTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TRTweetTableViewCell.tapEdit(_:)))
        profilePhotoImageView.addGestureRecognizer(tapGesture)
        //tapGesture.delegate = ViewController()
    }
    
    func tapEdit(sender: UITapGestureRecognizer) {
//        delegate?.myTableDelegate()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
