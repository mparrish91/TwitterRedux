//
//  TRMentionsViewController.swift
//  TwitterRedux
//
//  Created by parry on 11/5/16.
//  Copyright © 2016 parry. All rights reserved.

import UIKit
import AFNetworking

let kTweetsComposeNavigationControllerName = "TweetNavigationController"
let notificationNewTweet = Notification.Name("newTweet")
let notificationUserInfoTweetKey = "tweet"


class TRMentionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets: [TRTweet] = []
    var currentSelectedIndex = -1
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.title = "Timeline"
        
        // Initialize a pull to refresh UIRefreshControl
        refreshControl.addTarget(self, action: #selector(fetchTimeline), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
        
        // Do any additional setup after loading the view.
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // load the model and views
        fetchTimeline()
        
    }
    
    //MARK- Model
    func fetchTimeline () {
        TRTwitterNetworkingClient.sharedInstance.fetchTimeline(completion: { (response) in
            if let response = response {
                self.tweets = response
                self.tableView.reloadData()
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
        currentSelectedIndex = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

//    // MARK: Actions
//    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
//        TwitterSessionManager.sharedInstance.logout()
//    }
//    
//    @IBAction func composeButtonTapped(_ sender: UIBarButtonItem) {
//        TweetComposeViewController.present(from: self)
//    }
//    

}
