//
//  ViewController.swift
//  MapTutorial
//
//  Created by Yoonseung Choi on 2015. 10. 19..
//  Copyright © 2015년 Yoonseung Choi. All rights reserved.
//

import UIKit
import MapKit // library for MapView
import EventKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var currentLatitude = 37.610926
    var currentLongitude = 126.997215
    var currentSpan = 0.005
    
    let eventStore = EKEventStore()
    
    /********************************
    
    
        Following is for
    
        viewDidLoad Function
    
    
    ********************************/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        var currentLocation
        = CLLocationCoordinate2DMake(currentLatitude, currentLongitude ) // location of Kookmin University
        var mapSpan
        = MKCoordinateSpanMake(currentSpan, currentSpan) // smaller value, closer view
        var mapRegion
        = MKCoordinateRegionMake(currentLocation, mapSpan)
        
        self.mapView.setRegion(mapRegion, animated: true)
        
        CurrentLocationController().latitude = currentLatitude
        CurrentLocationController().Longitude = currentLongitude
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var count = Int(0)
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        currentLatitude = mapView.region.center.latitude
        currentLongitude = mapView.region.center.longitude

    }
    
  }

