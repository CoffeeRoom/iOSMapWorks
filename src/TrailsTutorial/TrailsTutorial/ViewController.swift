//
//  ViewController.swift
//  TrailsTutorial
//
//  Created by Yoonseung Choi on 2015. 11. 11..
//  Copyright © 2015년 Yoonseung Choi. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController {

    @IBOutlet weak var TrailsMapView: MKMapView!

    var xml:XMLIndexer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
        enumerate(xml, level: 0)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func enumerate(indexer: XMLIndexer, level: Int) {
        
        var count = 0;
        
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
                
                print("[\(count++)] lon: \(lon), lat: \(lat), ele: \(ele)")
            
                /*****  MKPolyline be here !!  *****/
            }
            
            enumerate(child, level: level + 1)
        }
    }

}

