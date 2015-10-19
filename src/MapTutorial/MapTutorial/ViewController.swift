//
//  ViewController.swift
//  MapTutorial
//
//  Created by Yoonseung Choi on 2015. 10. 19..
//  Copyright © 2015년 Yoonseung Choi. All rights reserved.
//

import UIKit
import MapKit // library for MapView

class ViewController: UIViewController {


    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var UpButton: UIButton!
    @IBOutlet weak var DownButton: UIButton!
    @IBOutlet weak var LeftButton: UIButton!
    @IBOutlet weak var RightButton: UIButton!

    var currentLatitude = 37.610926
    var currentLongitude = 126.997215
    var currentSpan = 0.005
    
    /********************************
    
    
        Following is for
    
        viewDidLoad Function
    
    
    ********************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        setMapRegion()
        
        UpButton.addTarget(self, action: "UpPressed:",forControlEvents: .TouchUpInside)
        DownButton.addTarget(self, action: "DownPressed:",forControlEvents: .TouchUpInside)
        LeftButton.addTarget(self, action: "LeftPressed:",forControlEvents: .TouchUpInside)
        RightButton.addTarget(self, action: "RightPressed:",forControlEvents: .TouchUpInside)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /********************************
    
    
        following is for
    
        Map Moving Functionality
    

    ********************************/
    
    let moveValue = 0.0001
    
    func UpPressed(sender: UIButton!)
    {
        currentLatitude += moveValue
        setMapRegion()
    }
    
    func DownPressed(sender: UIButton!)
    {
        currentLatitude -= moveValue
        setMapRegion()
    }
    
    func LeftPressed(sender: UIButton!)
    {
        currentLongitude -= moveValue
        setMapRegion()
    }
    func RightPressed(sender: UIButton!)
    {
        currentLongitude += moveValue
        setMapRegion()
    }
    
    
    func setMapRegion() {
        var currentLocation
        = CLLocationCoordinate2DMake(currentLatitude, currentLongitude ) // location of Kookmin University
        var mapSpan
        = MKCoordinateSpanMake(currentSpan, currentSpan) // smaller value, closer view
        var mapRegion
        = MKCoordinateRegionMake(currentLocation, mapSpan)
        
        self.map.setRegion(mapRegion, animated: true)
    }
}

