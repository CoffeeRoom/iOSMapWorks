//
//  CurrentLocationController.swift
//  MapTutorial
//
//  Created by Yoonseung Choi on 2015. 10. 20..
//  Copyright © 2015년 Yoonseung Choi. All rights reserved.
//

import UIKit
import MapKit
import EventKit

class CurrentLocationController: ViewController {
    
    @IBOutlet weak var LatitudeTextField: UITextField!
    @IBOutlet weak var LongtitudeTextField: UITextField!
    
    override func viewDidLoad() {
//        LatitudeTextField.placeholder = String(super.currentLatitude)
//        LongtitudeTextField.placeholder = String(super.currentLongitude)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        LatitudeTextField.placeholder = String(super.currentLatitude)
        LongtitudeTextField.placeholder = String(super.currentLongitude)
    }
    
    
 
}
