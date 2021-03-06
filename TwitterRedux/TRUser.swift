//
//  TRUser.swift
//  TwitterRedux
//
//  Created by parry on 11/6/16.
//  Copyright © 2016 parry. All rights reserved.
//

import UIKit

let kUserNameKey = "name"
let kUserScreennameKey = "screen_name"
let kUserProfileImageURLKey = "profile_image_url_https"
let kUserProfileBackgroundImageURLKey = "profile_banner_url"
let kUserDescriptionKey = "description"
let kUserDefaultsCurrentUserDataKey = "SimpleTwitterCurrentUserData"
let kUserFollowersKey = "followers_count"
let kUserFollowing = "friends_count"
let kUserTotalTweets = "statuses_count"




class TRUser: NSObject {
    var name: String?
    var screenname: String?
    var profileURL: URL?
    var profileBackgroundURL: URL?
    var userDescription: String?
    var totalTweets: Int = -1
    var totalFollowers:Int = -1
    var totalFollowing:Int = -1
    var userDictionary: NSDictionary
    
    init(with dictionary: NSDictionary) {
        userDictionary = dictionary
        
        name = dictionary[kUserNameKey] as? String
        
        screenname = dictionary[kUserScreennameKey] as? String
        
        if let profileURLString = dictionary[kUserProfileImageURLKey] as? String {
            profileURL = URL(string: profileURLString)
        }
        
        if let profileBackgroundURLString = dictionary[kUserProfileBackgroundImageURLKey] as? String {
            profileBackgroundURL = URL(string: profileBackgroundURLString)
        }
        
        userDescription = dictionary[kUserDescriptionKey] as? String
        
        totalTweets = (dictionary[kUserTotalTweets] as? Int)!
        totalFollowers = (dictionary[kUserFollowersKey] as? Int)!
        totalFollowing = (dictionary[kUserFollowing] as? Int)!

    }
    
    class var currentUser: TRUser? {
        get {
            let defaults = UserDefaults.standard
            
            if let userData = defaults.object(forKey: kUserDefaultsCurrentUserDataKey) as? Data {
                let dictionary = try! JSONSerialization.jsonObject(with: userData, options: [])
                let user = TRUser(with: dictionary as! NSDictionary)
                return user
            }
            
            return nil
        }
        set(user) {
            let defaults = UserDefaults.standard
            
            // Unwrap user and save serialized (dict) info to defaults
            if let user = user {
                // Save serialized dictionary of user
                let data = try! JSONSerialization.data(withJSONObject: user.userDictionary, options: [])
                defaults.set(data, forKey: kUserDefaultsCurrentUserDataKey)
                print("Serialized current user and saving to defaults")
            }
            else {
                defaults.removeObject(forKey: kUserDefaultsCurrentUserDataKey)
            }
            
            defaults.synchronize()
        }
    }
}
