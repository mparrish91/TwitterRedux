//
//  TRProfileViewController.swift
//  TwitterRedux
//
//  Created by parry on 11/5/16.
//  Copyright © 2016 parry. All rights reserved.
//

import UIKit

let kTweetsTableViewCellIdentifier = "TweetTableViewCell"

class TRProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tweetsTableView: UITableView!
    
    @IBOutlet weak var headerBackgroundImageView: UIImageView!
    
    @IBOutlet weak var headerProfilePhotoImageView: UIImageView!
    
    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var followersLabel: UILabel!
    
    @IBOutlet weak var settingsButton: UIButton!
    
    @IBOutlet weak var accountsButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var accountLabel: UILabel!
    
    var tweets: [TRTweet] = []
    let refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.title = "Timeline"
        
        // Initialize a pull to refresh UIRefreshControl
        refreshControl.addTarget(self, action: #selector(fetchTimeline), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tweetsTableView.insertSubview(refreshControl, at: 0)

        tweetsTableView.estimatedRowHeight = 50
        tweetsTableView.rowHeight = UITableViewAutomaticDimension
        
        // load the model and views
        fetchTimeline()

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



}
