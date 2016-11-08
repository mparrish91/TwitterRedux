//
//  TRProfileHeaderView.swift
//  TwitterRedux
//
//  Created by parry on 11/7/16.
//  Copyright © 2016 parry. All rights reserved.
//

import UIKit

class TRProfileHeaderView: UIView {
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "TRProfileHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    @IBOutlet weak var headerBackgroundImageView: UIImageView!
    
    @IBOutlet weak var headerProfilePhotoImageView: UIImageView!
    
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var followersLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var accountLabel: UILabel!


}
