//
//  TRLoadingViewController.swift
//  TwitterRedux
//
//  Created by parry on 11/6/16.
//  Copyright © 2016 parry. All rights reserved.
//

import UIKit

class TRLoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        // Create CAShapeLayerS
        let rectShape = CAShapeLayer()
        rectShape.bounds = bounds
        rectShape.position = view.center
        rectShape.cornerRadius = bounds.width / 2
        view.layer.addSublayer(rectShape)
        
        // Apply effects here
        // 1
        rectShape.path = UIBezierPath(ovalIn: rectShape.bounds).cgPath
        
        rectShape.lineWidth = 4.0
        rectShape.strokeColor = UIColor.white.cgColor
        rectShape.fillColor = UIColor.clear.cgColor
        
        // 2
        rectShape.strokeStart = 0
        rectShape.strokeEnd = 0.3
        
        // 3
        let start = CABasicAnimation(keyPath: "strokeStart")
        start.toValue = 0.9
        let end = CABasicAnimation(keyPath: "strokeEnd")
        end.toValue = 1
        
        // 4
        let group = CAAnimationGroup()
        group.animations = [start, end]
        group.duration = 0.6
        group.autoreverses = false
        group.repeatCount = HUGE // repeat forver
        rectShape.add(group, forKey: nil)
    }
    

}
