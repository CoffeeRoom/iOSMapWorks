//
//  DragPinsOnMapController.swift
//  MapTutorial
//
//  Created by Yoonseung Choi on 2015. 10. 20..
//  Copyright © 2015년 Yoonseung Choi. All rights reserved.
//

import UIKit
import MapKit

class DragPinsOnMapController: UIViewController {
  
    override func viewDidLoad() {
        
        
    }
    
    var pinClicked=false
    
    @IBOutlet weak var OrangePinButton: UIButton!
    @IBAction func OrangePinButtonPushed(sender: AnyObject) {
        pinClicked = true
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        OrangePinButton.center = (touches.first?.locationInView(view))!
    }
    
    
}