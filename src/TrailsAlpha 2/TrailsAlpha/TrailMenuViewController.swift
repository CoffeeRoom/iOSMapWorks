//
//  TrailMenuViewController.swift
//  TrailsAlpha
//
//  Created by Yoon on 2016. 1. 10..
//  Copyright © 2016년 Yoonseung Choi. All rights reserved.
//

import UIKit

class TrailMenuViewController: UIViewController {
    
    @IBOutlet weak var TrailListTable: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        TrailListTable.bounces = false
        
        TrailListTable.backgroundView =  UIImageView(image: UIImage(named: "swipe2.jpg"))
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = TrailListTable.bounds
        TrailListTable.insertSubview(blurView, atIndex: 0)
        
        
    }
    
}