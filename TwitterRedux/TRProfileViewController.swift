//
//  TRProfileViewController.swift
//  TwitterRedux
//
//  Created by parry on 11/5/16.
//  Copyright © 2016 parry. All rights reserved.
//

import UIKit

let kTweetsTableViewCellIdentifier = "TRTweetTableViewCell"

class TRProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tweetsTableView: UITableView!
    
    @IBOutlet weak var headerBackgroundImageView: UIImageView!
    
    @IBOutlet weak var headerProfilePhotoImageView: UIImageView!
    
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var followersLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var accountLabel: UILabel!
    
    var tweets: [TRTweet] = []
    let refreshControl = UIRefreshControl()

    @IBOutlet weak var headerView: UIView!
    
    

    
    static func instantiateCustom(username: String) -> TRProfileViewController
    {
        let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TRProfileViewController") as! TRProfileViewController
        //fetch user

        
        //fetch timeline
        
        TRTwitterNetworkingClient.sharedInstance.fetchUserTimeline(screenname: username,completion: { (response) in
            if let response = response {
                profileVC.tweets = response
            }
        }) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
        
        
        TRTwitterNetworkingClient.sharedInstance.fetchUserAccount(screenname: username,completion: { (user: TRUser) in
            // Save current user account
            profileVC.tweetsLabel.text = String(user.totalTweets)
            profileVC.followersLabel.text = String(user.totalFollowers)
            profileVC.followingLabel.text = String(user.totalFollowing)
            profileVC.nameLabel.text = user.name
            profileVC.accountLabel.text = "@" + user.screenname!
            profileVC.headerProfilePhotoImageView.setImageWith(user.profileURL!)
            profileVC.headerBackgroundImageView.setImageWith(user.profileBackgroundURL!)
            profileVC.navigationController?.navigationBar.topItem?.title = user.name
            
            }, failure: { (error: Error) in
        })

    
        return profileVC
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Initialize a pull to refresh UIRefreshControl
        refreshControl.addTarget(self, action: #selector(fetchTimeline), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tweetsTableView.insertSubview(refreshControl, at: 0)

        tweetsTableView.estimatedRowHeight = 100
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        
        // load the model and views
        fetchTimeline()
        
        headerProfilePhotoImageView.layer.cornerRadius = 15
        headerProfilePhotoImageView.layer.masksToBounds = true

        
        if let user = TRUser.currentUser {
        tweetsLabel.text = String(user.totalTweets)
        followersLabel.text = String(user.totalFollowers)
        followingLabel.text = String(user.totalFollowing)
        nameLabel.text = user.name
        accountLabel.text = "@" + user.screenname!
        headerProfilePhotoImageView.setImageWith(user.profileURL!)
        headerBackgroundImageView.setImageWith(user.profileBackgroundURL!)
        navigationController?.navigationBar.topItem?.title = user.name
        }
        
    }
    
    
    func fetchTimeline () {
        TRTwitterNetworkingClient.sharedInstance.fetchTimeline(completion: { (response) in
            if let response = response {
                self.tweets = response
                self.tweetsTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }


    // MARK: - tableView methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTweetsTableViewCellIdentifier, for: indexPath) as! TRTweetTableViewCell
        
        // Set model
        let tweet = tweets[indexPath.row]
        
        // Configure cell
        if let text = tweet.text {
            cell.tweetTextLabel.text = text
        }
        
        // Configure user contents
        if let user = tweet.user {
            cell.nameLabel.text = user.name
            cell.accountLabel.text = "@" + user.screenname!
            if let url = user.profileURL {
                cell.profilePhotoImageView.setImageWith(url)
            }
        }
        
        if let timeSince = tweet.timeSinceNowString {
            cell.timeLabel.text = timeSince
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//     func tableView(_ tableView: UITableView,
//                            viewForHeaderInSection section: Int) -> UIView?
//    {
//        
//        let view = TRProfileHeaderView.instanceFromNib() as! TRProfileHeaderView
//        if let user = TRUser.currentUser {
//            view.tweetsLabel.text = String(user.totalTweets)
//            view.followersLabel.text = String(user.totalFollowers)
//            view.followingLabel.text = String(user.totalFollowing)
//            view.nameLabel.text = user.name
//            view.accountLabel.text = "@" + user.screenname!
//            view.headerProfilePhotoImageView.setImageWith(user.profileURL!)
//            view.headerBackgroundImageView.setImageWith(user.profileBackgroundURL!)
//            navigationController?.navigationBar.topItem?.title = user.name
//        }
//
//        return view
//        
//
//    }
    
    
//     func tableView(_ tableView: UITableView,
//                            heightForHeaderInSection section: Int) -> CGFloat {
//        return 80
//    }
    


}
