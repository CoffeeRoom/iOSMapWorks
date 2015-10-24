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
    
    @IBOutlet weak var map: MKMapView!
    
    var PinHolder: CGPoint!
    
    override func  viewDidLoad() {
        PinHolder = Pin.center

    }
    
    var touchedFlag = false
    
    @IBOutlet weak var Pin: UIImageView!
    @IBOutlet weak var OrangeButton: UIButton!
    
    @IBAction func OrangeTouched(sender: AnyObject) {
        touchedFlag = true
        Pin.image = UIImage(named: "OrangePin")!
        print("on touch")
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touchedFlag {
            Pin.layer.zPosition = 1
            Pin.center = (touches.first?.locationInView(view))!
            Pin.center.y -= 32
        }
        print("touch")
        print(touchedFlag)
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchedFlag = false
        Pin.center = PinHolder
        Pin.image = UIImage(named: "GrayPin")


        print("off touch")
    }
    
}
