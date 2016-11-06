//
//  TRLoginViewController.swift
//  TwitterRedux
//
//  Created by parry on 11/6/16.
//  Copyright © 2016 parry. All rights reserved.
//

import UIKit


class TRLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButtonPressed(_ sender: UIButton) {
        // Login to Twitter
        // Start OAuth session manager & initiate token request
        TRTwitterNetworkingClient.sharedInstance.login(completion: {
            self.present(LoginViewController.getRootVCAfterLogin(), animated: true, completion: {
                // Completion code
            })
            
        }) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
