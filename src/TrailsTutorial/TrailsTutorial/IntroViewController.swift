//
//  IntroViewController.swift
//  TrailsTutorial
//
//  Created by Yoonseung Choi on 2015. 11. 26..
//  Copyright © 2015년 Yoonseung Choi. All rights reserved.
//


import UIKit
import MapKit

class IntroViewController: UIViewController {
    
    @IBOutlet weak var BackgroundImageView: UIImageView!
    @IBOutlet weak var MapViewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBlurEffectedBackground()
        
        setIconOfButtonWithTitle(MapViewButton, imageName: "map", title: "지도")
        
        MapViewButton.layer.cornerRadius = 60
        MapViewButton.layer.masksToBounds = true
        
        
    }
    
    func setBlurEffectedBackground() {
        
        let blurEffect = UIBlurEffect(style: .Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = BackgroundImageView.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        BackgroundImageView.addSubview(blurEffectView)
    }
    
    func setIconOfButtonWithTitle(button: UIButton!, imageName: String, title: String){
        
        button.setTitle(title, forState: .Normal)
        button.setImage(UIImage(named: imageName), forState: .Normal)
        
        button.tintColor = UIColor.whiteColor()
        
    }
    
}