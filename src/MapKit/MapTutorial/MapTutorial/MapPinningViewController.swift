//
//  MapPinningViewController.swift
//  MapTutorial
//
//  Created by Yoonseung Choi on 2015. 10. 23..
//  Copyright © 2015년 Yoonseung Choi. All rights reserved.
//

import UIKit
import MapKit
<<<<<<< HEAD
=======

>>>>>>> origin/master

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
<<<<<<< HEAD
        OrangePin.imageView?.image = UIImage(named: "OrangePin")
=======
        Pin.image = UIImage(named: "OrangePin")!
>>>>>>> origin/master
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
<<<<<<< HEAD
       OrangePin.imageView?.image = UIImage(named: "GrayPin")
        
        var myPin = MKPointAnnotation()
        //myPin.coordinate = touches.first?.locationInView(view)
        
=======
        Pin.center = PinHolder
        Pin.image = UIImage(named: "GrayPin")
>>>>>>> origin/master


        print("off touch")
    }
    
}
