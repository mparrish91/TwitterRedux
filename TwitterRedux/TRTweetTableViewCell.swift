//
//  TRTweetTableViewCell.swift
//  TwitterRedux
//
//  Created by parry on 11/5/16.
//  Copyright © 2016 parry. All rights reserved.
//

import UIKit

protocol TRTweetCellDelegate: class {
    func profilePhotoImageViewTapped(tweet: TRTweet)
}


class TRTweetTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    
    weak var delegate: TRTweetCellDelegate?
    var tweet: TRTweet?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
        //tapGesture.delegate = ViewController()
    }
    
    func tapEdit(sender: UITapGestureRecognizer) {
        delegate?.profilePhotoImageViewTapped(tweet: tweet!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TRTweetTableViewCell.tapEdit(sender:)))
        profilePhotoImageView.addGestureRecognizer(tapGesture)
    }

}
