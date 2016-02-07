//
//  EmergencyViewController.swift
//  TrailsAlpha
//
//  Created by Yoon on 2016. 1. 9..
//  Copyright © 2016년 Yoonseung Choi. All rights reserved.
//

import UIKit
import MapKit

class EmergencyViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var CurrentLocationMapView: MKMapView!

    let locationManager = CLLocationManager()
    var timer = NSTimer()

    override func viewDidLoad() {
        
        self.locationManager.delegate = self
        
        // set highest accuracy
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.startUpdatingLocation()
        self.CurrentLocationMapView.showsUserLocation = true
        
    }
    
    override func viewDidAppear(animated: Bool) {
        // get user location and move map scope to user
        
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("moveMapScopeToCurrentLocation"), userInfo: nil, repeats: true)
        
    }
    
    
    
    override func viewWillDisappear(animated:Bool){
        super.viewWillDisappear(animated)
        self.applyMapViewMemoryFix()
        
        timer.invalidate()
    }
    
    func applyMapViewMemoryFix(){
        switch (self.CurrentLocationMapView.mapType) {
        case MKMapType.Hybrid:
            self.CurrentLocationMapView.mapType = MKMapType.Standard
            break;
        case MKMapType.Standard:
            self.CurrentLocationMapView.mapType = MKMapType.Hybrid
            break;
        default:
            break;
        }
        self.CurrentLocationMapView.showsUserLocation = false
        self.CurrentLocationMapView.delegate = nil
        self.CurrentLocationMapView.removeFromSuperview()
        self.CurrentLocationMapView = nil
        
        self.locationManager.stopUpdatingLocation()
        self.locationManager.delegate = nil
        
    }
    
    
    func moveMapScopeToCurrentLocation() {
        print(".")

        if let coordinate = self.CurrentLocationMapView.userLocation.location?.coordinate {
            
            var location = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
            var region = MKCoordinateRegion(center: location, span: MKCoordinateSpanMake(0.0015, 0.0015))
            
            self.CurrentLocationMapView.setRegion(region, animated: true)
            
        }
    }
    
    @IBAction func CallingButtonPushed(sender: AnyObject) {

        timer.invalidate()
        
        let phoneNumber = "010-0000-0000"

        if let url = NSURL(string: "tel://\(phoneNumber)") {
            UIApplication.sharedApplication().openURL(url)
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("moveMapScopeToCurrentLocation"), userInfo: nil, repeats: true)
        
    }
    @IBAction func CancelButtonPushed(sender: AnyObject) {

        //timer.invalidate()
    }
    
}