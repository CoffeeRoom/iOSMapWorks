//
//  MapViewController.swift
//  TrailsTutorial
//
//  Created by Yoonseung Choi on 2015. 11. 11..
//  Copyright © 2015년 Yoonseung Choi. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var TrailsMapView: MKMapView!
    @IBOutlet weak var EmergencyCallButtonItem: UIButton!
    @IBOutlet weak var TrailListButtonItem: UIBarButtonItem!
    
    var gpx:[XMLIndexer]! = []

    var pointToDraw:[CLLocationCoordinate2D] = []
    var pointCount = 0;
    
    lazy var pointToAnnotate:[NewAnnotation] = []
    
    var currentLatitude = 37.743813
    var currentLongitude = 127.137349
    var currentSpan = 0.008
    
    // property for current location
    let locationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // request permission whihe the app is in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        // Set map view coordinate
        setRegionOfTrailMap(self.TrailsMapView, latitude: currentLatitude, longtitude: currentLongitude, span: currentSpan)
        
        // revealView global value test
        self.revealViewController().trail = 5
        print(self.revealViewController().trail)
        
        
        drawTrack("viewDidLoad")
        
        // set gesture event for SWRevealView
        if self.revealViewController() != nil {
            TrailListButtonItem.target = self.revealViewController()
            TrailListButtonItem.action = "rightRevealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        EmergencyCallButtonItem.setImage(UIImage(named: "alert32"), forState: UIControlState.Normal)
        EmergencyCallButtonItem.tintColor = UIColor.redColor()
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        for chosenGPX in gpx {
            
            /* Draw polyline in the map view */
            
            pointCount = 0
            pointToDraw = []
            enumerateForTrack(chosenGPX, level: 0)
            
            // !!! important: Must link MapView's deligate with ViewController in Storyboard
            let myPolyline = MKPolyline(coordinates: &pointToDraw, count: pointCount)
            TrailsMapView.addOverlay(myPolyline)

            
            /* Pin annotation in the Map view */
            
            pointCount = 0
            enumerateForWaypoint(chosenGPX, level: 0)
            TrailsMapView.addAnnotations(pointToAnnotate)
            
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewWillDisappear(animated:Bool){
        super.viewWillDisappear(animated)
        self.applyMapViewMemoryFix()
    }
    
    func applyMapViewMemoryFix(){
        switch (self.TrailsMapView.mapType) {
        case MKMapType.Hybrid:
            self.TrailsMapView.mapType = MKMapType.Standard
            break;
        case MKMapType.Standard:
            self.TrailsMapView.mapType = MKMapType.Hybrid
            break;
        default:
            break;
        }
        self.TrailsMapView.showsUserLocation = false
        self.TrailsMapView.delegate = nil
        self.TrailsMapView.removeFromSuperview()
        self.TrailsMapView = nil
        
    }
    
    
    
    
    @IBAction func BackButtonPushed(sender: AnyObject) {
        print("go back")
    }
    
    
    
    func setRegionOfTrailMap(mapView: MKMapView, latitude: Double, longtitude: Double, span: Double) {
        
        var location
        = CLLocationCoordinate2DMake(latitude, longtitude ) // location of Kookmin University
        var mapSpan
        = MKCoordinateSpanMake(span, span) // smaller value, closer view
        var mapRegion
        = MKCoordinateRegionMake(location, mapSpan)
        
        self.TrailsMapView.setRegion(mapRegion, animated: true)
    }
    
    
    
    
    
    func GPXFileToParsedArrayByFilepath(filename: String, type: String)->XMLIndexer! {
        if let filepath = NSBundle.mainBundle().pathForResource(filename, ofType: type) {
            do {
                let contents = try NSString(contentsOfFile: filepath, usedEncoding: nil) as String
                //xml = SWXMLHash.parse(contents) // yoon // parse xml and make XMLIndexer
                return SWXMLHash.parse(contents)
            } catch {
                // contents could not be loaded
                print("contents load failed\n")
            }
        } else {
            // example.txt not found!
            print("there is no contents\n")
        }
        return nil as XMLIndexer!
    }
    
    
    
    /***********************************************************************
    * Functions for showing current location
    *
    * 1. showCurrentLocation
    *    : shows current location
    *
    * Reference: Map View - Current Location in Swift - Xcode 7 iOS 9 Tutorial
    * https://www.veasoftware.com/tutorials/2015/7/25/map-view-current-location-in-swift-xcode-7-ios-9-tutorial
    ***********************************************************************/
    
    @IBAction func showCurrentLocation(sender: AnyObject) {
        
        self.locationManager.delegate = self
        
        // set highest accuracy
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.startUpdatingLocation()
        self.TrailsMapView.showsUserLocation = true
    }
    
    
    
    /**********************************************************************
    * Functions for Drawing Track
    *
    * 1. enumerateForTrack
    *    : enumerate XML File and get values about Track
    *
    * 2. mapView
    *    : Handle Drawing Track
    *
    * <note>
    *
    *   child.element?.attributes["lon"] is String optional
    *   -> Float(child.element?.attributes["lon"])!) is Float optional
    *   -> Float((child.element?.attributes["lon"])!)!
    *
    **********************************************************************/

    
    func enumerateForTrack(indexer: XMLIndexer, level: Int) {
        
        for child in indexer.children {
            
            if(child.element!.name == "trkpt") { // yoon // for drawing track
                
                let lon = Double((child.element?.attributes["lon"])!)!
                let lat = Double((child.element?.attributes["lat"])!)!
                
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
            lineView.strokeColor = UIColor(
                red: CGFloat(drand48()),
                green: CGFloat(drand48()),
                blue: CGFloat(drand48()),
                alpha: 1.0)
            
            return lineView
        }
        
        return nil
    }
    
    
    // Get path of GPX file and parse
    // need to optimize
    //gpx.append(GPXFileToParsedArrayByFilepath("example", type: "gpx"))
    func drawTrack(trail:String) {
        
        switch (trail) {
            
        case "viewDidLoad" :
            gpx.append(GPXFileToParsedArrayByFilepath("A", type: "gpx"))
            gpx.append(GPXFileToParsedArrayByFilepath("B", type: "gpx"))
            gpx.append(GPXFileToParsedArrayByFilepath("C", type: "gpx"))
            gpx.append(GPXFileToParsedArrayByFilepath("D", type: "gpx"))
            break
            
        default:
            gpx.append(GPXFileToParsedArrayByFilepath(trail, type: "gpx"))

            break
  
        }
    }
    
    
    
    /***********************************************************************
    * Functions for Adding Annotations
    *
    * 1. enumerateForWayPoint
    *    : enumerate XML File and get values about Way point
    *
    * 2. mapView
    *    : Handle Annotation Adding
    ***********************************************************************/
    
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
                
//                print("[\(pointCount)]]")
//                print("name: \(name)")
//                print("desc: \(desc)\n");
                
                
                // add annotation to array
                pointToAnnotate += [NewAnnotation(coordinate: CLLocationCoordinate2DMake(lat, lon), title: name, subtitle: desc)]

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
                // yoon // if let pinImgView = UIImageView(image: UIImage(named: "pin"))
                //                annotationView.addSubview(pinImgView)
                
                annotationView.enabled = true
                annotationView.canShowCallout = true
                
                let newAnnotation = annotation as! NewAnnotation
                
                let btn = UIButton(type: .DetailDisclosure)
                annotationView.rightCalloutAccessoryView = btn
                
                if (newAnnotation.imageName != nil) {
                    annotationView.image = UIImage(named: newAnnotation.imageName)
                }
                
                return annotationView
            }
        }
        
        return nil
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.isKindOfClass(SWRevealViewControllerSeguePushController)) {
            print("hello")
        }
    }
    
}

/************************************************************************/

class NewAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String!
    var subtitle: String!
    var color: String!
    var imageName: String!
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.imageName = nil
        
        super.init()
    }
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, imageName: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName

        super.init()
    }
}



