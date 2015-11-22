//
//  ViewController.swift
//  TrailsTutorial
//
//  Created by Yoonseung Choi on 2015. 11. 11..
//  Copyright © 2015년 Yoonseung Choi. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var TrailsMapView: MKMapView!

    var xml:XMLIndexer!
    
    var pointToDraw:[CLLocationCoordinate2D]=[]
    var pointCount = 0;
    
    var pointToAnnotate:[NewAnnotation]=[]
    
    var currentLatitude = 37.743813
    var currentLongitude = 127.139749
    var currentSpan = 0.02
    
    // property for current location
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // request permission whihe the app is in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        /**********  Set Coordinate region  **********/
        
        var currentLocation
        = CLLocationCoordinate2DMake(currentLatitude, currentLongitude ) // location of Kookmin University
        var mapSpan
        = MKCoordinateSpanMake(currentSpan, currentSpan) // smaller value, closer view
        var mapRegion
        = MKCoordinateRegionMake(currentLocation, mapSpan)
        
        self.TrailsMapView.setRegion(mapRegion, animated: true)
        
        /**********  MKPolyline be here !!  **********/
        
        if let filepath = NSBundle.mainBundle().pathForResource("example", ofType: "gpx") {
            do {
                let contents = try NSString(contentsOfFile: filepath, usedEncoding: nil) as String
                //print(contents)
                xml = SWXMLHash.parse(contents) // yoon // parse xml and make XMLIndexer
                
            } catch {
                // contents could not be loaded
                print("contents load failed\n")
            }
        } else {
            // example.txt not found!
            print("there is no contents\n")
        }
        
        /**********  MKPolyline be here !!  **********/

        pointCount = 0
        enumerateForTrack(xml, level: 0)

        let myPolyline = MKPolyline(coordinates: &pointToDraw, count: pointCount)
        TrailsMapView.addOverlay(myPolyline)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        /**********  Annotation be here !!  **********/
        
        pointCount = 0
        enumerateForWaypoint(xml, level: 0)
        TrailsMapView.addAnnotations(pointToAnnotate)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    * Functions for showing current location
    *
    * 1. showCurrentLocation
    *    : shows current location
    *
    * Reference: Map View - Current Location in Swift - Xcode 7 iOS 9 Tutorial
    * https://www.veasoftware.com/tutorials/2015/7/25/map-view-current-location-in-swift-xcode-7-ios-9-tutorial
    */
    
    
    @IBAction func showCurrentLocation(sender: AnyObject) {
        
        self.locationManager.delegate = self
        
        // set highest accuracy
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.startUpdatingLocation()
        self.TrailsMapView.showsUserLocation = true
    }
    
    /*
     * Functions for Drawing Track
     *
     * 1. enumerateForTrack
     *    : enumerate XML File and get values about Track
     *
     * 2. mapView
     *    : Handle Annotation Adding
     */
    
    func enumerateForTrack(indexer: XMLIndexer, level: Int) {
        
        for child in indexer.children {
            
            if(child.element!.name == "trkpt") { // yoon // for drawing track
                /*
                    child.element?.attributes["lon"] is String optional
                    -> Float(child.element?.attributes["lon"])!) is Float optional
                    -> Float((child.element?.attributes["lon"])!)!
                */
                var lon = Double((child.element?.attributes["lon"])!)!
                var lat = Double((child.element?.attributes["lat"])!)!
                var ele = Double((child["ele"].element?.text!)!)!
                
                //print("[\(pointCount)] lon: \(lon), lat: \(lat), ele: \(ele)")
                
                pointCount+=1
            
                /*****  MKPolyline be here !!  *****/
                pointToDraw += [CLLocationCoordinate2DMake(lat, lon)]
            }
            
            enumerateForTrack(child, level: level + 1)
        }
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKPolyline {
            let lineView = MKPolylineRenderer(overlay: overlay)
            lineView.strokeColor = UIColor.greenColor()
            
            return lineView
        }
        
        return nil
    }
    
    /*
    * Functions for Adding Annotations
    *
    * 1. enumerateForWayPoint
    *    : enumerate XML File and get values about Way point
    *
    * 2. mapView
    *    : Handle Annotation Adding
    */
    
    func enumerateForWaypoint(indexer: XMLIndexer, level: Int) {
        
        for child in indexer.children {
            
            if(child.element!.name == "wpt") { // yoon // for annotation
                
                let lon = Double((child.element?.attributes["lon"])!)!
                let lat = Double((child.element?.attributes["lat"])!)!
                let ele = Double((child["ele"].element?.text!)!)!

                let name = String(UTF8String: (child["name"].element?.text)!)!
                
                var desc = (child["extensions"]["description"].element?.text == nil ?
                    "No description" : String(UTF8String: (child["extensions"]["description"].element?.text)!)! )
                
                pointCount += 1
                
                //print("[\(pointCount)] lon: \(lon), lat: \(lat), ele: \(ele)")
                print("[\(pointCount)]]")
                print("name: \(name)")
                print("desc: \(desc)\n");
                
                
                // add annotation to array
                pointToAnnotate += [NewAnnotation(coordinate: CLLocationCoordinate2DMake(lat, lon), title: name, subtitle: desc)]
                    
//                TrailsMapView.addAnnotation( 
//                    NewAnnotation(coordinate: CLLocationCoordinate2DMake(lat, lon), title: name, subtitle: desc)
//                )
            }
            enumerateForWaypoint(child, level: level+1)
        }
    }
    // reference: Annotations and accessory views: MKPinAnnotationView
    // https://www.hackingwithswift.com/read/19/3/annotations-and-accessory-views-mkpinannotationview
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "NewAnnotation"
        
        if annotation.isKindOfClass(NewAnnotation.self) {
            if let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) {
                
                annotationView.annotation = annotation
                return annotationView
            }
            else {
                let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
                
                // set pin image subview
//                let pinImgView = UIImageView(image: UIImage(named: "pin"))
//                annotationView.addSubview(pinImgView)
                
                annotationView.enabled = true
                annotationView.canShowCallout = true
                
                let btn = UIButton(type: .DetailDisclosure)
                annotationView.rightCalloutAccessoryView = btn
                
                return annotationView
            }
        }
        
        return nil
    }
    
}

class NewAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String!
    var subtitle: String!

    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle

        super.init()
    }
}



