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

class CurrentLocationController: UIViewController {
    
    @IBOutlet weak var LatitudeTextField: UITextField!
    @IBOutlet weak var LongitudeTextField: UITextField!
    
    var latitude: Double = 0
    var Longitude: Double = 0
        
    var text = "init"

    func setLatitudeTextFieldPlaceholder(latitude : Double) {
        text = String(latitude)
        if let textField : UITextField! = LatitudeTextField {
            textField.placeholder = text
        }

        let MainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let ViewContainer: ViewController = MainStoryboard.instantiateViewControllerWithIdentifier("MainView") as! ViewController

        ViewContainer.currentLatitude += 0.1
        
        presentViewController(ViewContainer, animated: false, completion: nil)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        LatitudeTextField.placeholder = String(ViewController().currentLatitude)
        LongitudeTextField.placeholder = String(ViewController().currentLongitude)
        
    }
    
 
}
