//
//  TFHamburgerViewController.swift
//  TwitterRedux
//
//  Created by parry on 11/4/16.
//  Copyright © 2016 parry. All rights reserved.
//

import UIKit

class TFHamburgerViewController: UIViewController {
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    var menuViewController: UIViewController!
    {
        didSet {
            view.layoutIfNeeded()
            menuView.addSubview(menuViewController.view)
        }
    }
    
    var originalLeftMargin:CGFloat!

    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func onPan(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        
        if sender.state == .began
        {
         originalLeftMargin = leftMarginConstraint.constant

        }
        else if sender.state == .changed
        {

            leftMarginConstraint.constant = originalLeftMargin + translation.x
            
        }
        else if sender.state == .ended
        {
            UIView.animate(withDuration: 0.5, animations: {
                if velocity.x > 0
                {
                    self.leftMarginConstraint.constant = self.view.frame.size.width - 100
                }
                else
                {
                    self.leftMarginConstraint.constant = 0
                }
                self.view.layoutIfNeeded()
            })
            


        }
        
    }


}
