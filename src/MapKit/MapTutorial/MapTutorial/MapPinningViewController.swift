//
//  MapPinningViewController.swift
//  MapTutorial
//
//  Created by Yoonseung Choi on 2015. 10. 23..
//  Copyright © 2015년 Yoonseung Choi. All rights reserved.
//

import UIKit
import MapKit

class MapPinningViewController: UIViewController {
    override func  viewDidLoad() {
        OrangePin.imageView!.image = UIImage(named: "GrayPin")

    }
    
    var touchedFlag = false
    
    @IBOutlet weak var OrangePin: UIButton!
    
    @IBAction func touched(sender: AnyObject) {
        touchedFlag = true
        OrangePin.imageView?.image = UIImage(named: "OrangePin")
        print("on touch")
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touchedFlag {
            OrangePin.layer.zPosition = 1
            OrangePin.center = (touches.first?.locationInView(view))!
        }
        print("touch")
        print(touchedFlag)

    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchedFlag = false
       OrangePin.imageView?.image = UIImage(named: "GrayPin")
        
        var myPin = MKPointAnnotation()
        //myPin.coordinate = touches.first?.locationInView(view)
        


        print("off touch")
    }
    
}
