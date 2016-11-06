//
//  TFMenuViewController.swift
//  TwitterRedux
//
//  Created by parry on 11/4/16.
//  Copyright © 2016 parry. All rights reserved.
//

import UIKit

class TFMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var menuTableView: UITableView!
    var hamburgerViewController: TFHamburgerViewController!
    private var greenNavigationController: UIViewController!
    private var blueNavigationController: UIViewController!
    private var pinkNavigationController: UIViewController!

    var viewControllers: [UIViewController] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       greenNavigationController = storyboard.instantiateViewController(withIdentifier: "GreenNavigationController")
        blueNavigationController = storyboard.instantiateViewController(withIdentifier: "BlueNavigationController")

        pinkNavigationController = storyboard.instantiateViewController(withIdentifier: "PinkNavigationController")
        
        viewControllers.append(greenNavigationController)
        viewControllers.append(blueNavigationController)
        viewControllers.append(pinkNavigationController)
        
        hamburgerViewController.contentViewController = greenNavigationController

        
        menuTableView.tableFooterView = UIView()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuHeaderCell", for: indexPath) as! TRMenuHeaderTableViewCell
            
            cell.nameLabel?.text = "Gil Turner"
            cell.descriptionLabel?.text = "Co-founder at YC"
            
            cell.profilePhotoImageView.image = UIImage(named: "profile")
            
            
            return cell

        }
        else
        {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! TRMenuTableViewCell
        
        let titles = ["", "profile", "mentions", "feed"]

        cell.titleLabel?.text = titles[indexPath.row]
    
        cell.iconImageView.image = UIImage(named: titles[indexPath.row])
            
            return cell

        }

        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0
        {
            
        }
        else{
            hamburgerViewController.contentViewController = viewControllers[indexPath.row - 1]

        }
        

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == 0
        {
            return 100
        }
        else
        {
            return 50

        }
    }

}
