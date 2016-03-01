//
//  InformationViewController.swift
//  TrailsAlpha
//
//  Created by Yoonseung Choi on 2016. 2. 7..
//  Copyright © 2016년 Yoonseung Choi. All rights reserved.
//


import UIKit

class InformationViewController: UITableViewController {

    @IBOutlet weak var topNaviView: UIView!
    @IBOutlet weak var topNaviViewBackButton: UIButton!
    @IBOutlet weak var topNaviViewLabel: UILabel!
    
    @IBOutlet var InformationTableView: UITableView!
    
    @IBOutlet weak var DescCellView: UITableViewCell!
    @IBOutlet weak var DescCellContentView: UIView!
    
    @IBOutlet weak var FacilityCellView: UITableViewCell!
    @IBOutlet weak var FacilityCellContentView: UIView!
    
    @IBOutlet weak var PathCellView: UITableViewCell!
    @IBOutlet weak var PathCellContentView: UIView!
    
    
    @IBAction func NaverPushed(sender: AnyObject) {
        if let url = NSURL(string: "http://map.naver.com/?dlevel=12&lat=37.7355941&lng=127.1350702&query=6rK96riw64%2BEIOuCqOyWkeyjvOyLnCDrs4TrgrTrqbQg7Jqp7JWU7KCc7LKt66eQ6ri4IDI2LTE0&type=ADDRESS&tab=1&enc=b64") {
            UIApplication.sharedApplication().openURL(url)
        }
    }

    @IBAction func DaumPushed(sender: AnyObject) {
        if let url = NSURL(string: "http://map.daum.net/?urlX=529763&urlY=1176648&q=%EA%B2%BD%EA%B8%B0+%EB%82%A8%EC%96%91%EC%A3%BC%EC%8B%9C+%EB%B3%84%EB%82%B4%EB%A9%B4+%EC%9A%A9%EC%95%94%EC%A0%9C%EC%B2%AD%EB%A7%90%EA%B8%B8+26-14") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        InformationTableView.bounces = false
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        topNaviView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        blurView.frame = topNaviView.bounds
        topNaviView.insertSubview(blurView, atIndex: 0)
        
        
        InformationTableView.backgroundView =  UIImageView(image: UIImage(named: "information.jpg"))

        
        
        DescCellView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        DescCellContentView.backgroundColor = UIColor(white: 1, alpha: 0.6)
        
//        let descBlurView = UIVisualEffectView(effect: blurEffect)
//        descBlurView.frame = DescCellContentView.bounds
//        DescCellContentView.insertSubview(descBlurView, atIndex: 0)
        
        FacilityCellView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        FacilityCellContentView.backgroundColor = UIColor(white: 1, alpha: 0.6)
        
        PathCellView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        PathCellContentView.backgroundColor = UIColor(white: 1, alpha: 0.6)
        
        let selectedBlurView = UIVisualEffectView(effect:blurEffect)
        selectedBlurView.frame = PathCellView.bounds
        PathCellView.selectedBackgroundView = selectedBlurView
        
  
//        blurView.frame = DescCellContentView.bounds
//        DescCellContentView.addSubview(blurView)
        
        
    }

}