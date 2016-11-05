//
//  TFMenuViewController.swift
//  TwitterRedux
//
//  Created by parry on 11/4/16.
//  Copyright © 2016 parry. All rights reserved.
//

import UIKit

class TFMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var viewControllers = ["Profile", "Mentions", "Timeline"]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewControllers.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = viewControllers[indexPath.row]
        
        
        return cell
        
        
    }

}
