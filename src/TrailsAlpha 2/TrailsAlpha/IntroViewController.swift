//
//  IntroViewController.swift
//  TrailsAlpha
//
//  Created by Yoonseung Choi on 2015. 11. 30..
//  Copyright © 2015년 Yoonseung Choi. All rights reserved.
//

import UIKit

class IntroViewController: UITableViewController {
    
    //

    @IBOutlet var TableViewMenu: UITableView!
    @IBOutlet weak var ImageViewEvent: UIImageView!
    @IBOutlet weak var CopyrightLabel: UILabel!
    
    var refreshCtrl = UIRefreshControl() // 151208 // yoon // pull-to-refresh

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBlurEffectedBackground(ImageViewEvent)
        CopyrightLabel.text = "Copyright © 2015 CoffeeRoom All rights reserved."
        
        /* Pull to refresh
         *
         * Reference :
         * > https://grokswift.com/pull-to-refresh-swift-table-view/
         * > http://www.ioscreator.com/tutorials/add-pull-to-refresh-table-view-ios8-swift
         *
         */
        
//        print(UIImage(named: "SKIN.jpg"))
//        TableViewMenu.backgroundView = UIImageView(image: UIImage(named: "SKIN.jpg"))
        
        // set up the refresh control
        self.refreshCtrl.attributedTitle = NSAttributedString(string: "화면을 아래로 당겨 지도정보를 최신화합니다.")
        self.refreshCtrl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.TableViewMenu?.addSubview(self.refreshCtrl)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setBlurEffectedBackground(imageView: UIImageView) {
        
        let blurEffect = UIBlurEffect(style: .Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = imageView.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        imageView.addSubview(blurEffectView)
    }
    
    func refresh(sender: AnyObject) {
        print("refresh")
        
        let testString = "hello, This is for the test." as NSString
        let filePath = NSTemporaryDirectory() + "file.txt"
        
        do {
            try testString.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
        } catch {
            print("failed to write\n")
        }
        
        HTTPGet("http://203.246.112.77:15180") {
            (data: String, error: String?) -> Void in
            if error != nil {
                print(error)
            } else {
                print("data is : \n")
                print(data)
            }
        }
        
        if self.refreshCtrl.refreshing
        {
            self.refreshCtrl.endRefreshing()
        }
        
    }
    
    /* Have to set the NSAllowsArbitraryLoads key to YES under NSAppTransportSecurity dictionary in your .plist file */
    func HTTPsendRequest(request: NSMutableURLRequest,callback: (String, String?) -> Void) {
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request,completionHandler :
            {
                data, response, error in
                if error != nil {
                    callback("", (error!.localizedDescription) as String)
                } else {
                    callback(NSString(data: data!, encoding: NSUTF8StringEncoding) as! String,nil)
                }
        })
        
        task.resume() //Tasks are called with .resume()
        
    }
    
    func HTTPGet(url: String, callback: (String, String?) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!) //To get the URL of the receiver , var URL: NSURL? is used
        HTTPsendRequest(request, callback: callback)
    }

}

