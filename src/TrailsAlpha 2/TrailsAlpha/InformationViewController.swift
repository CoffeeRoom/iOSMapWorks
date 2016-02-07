//
//  InformationViewController.swift
//  TrailsAlpha
//
//  Created by Yoonseung Choi on 2016. 2. 7..
//  Copyright © 2016년 Yoonseung Choi. All rights reserved.
//


import UIKit

class InformationViewController: UITableViewController {

    @IBAction func NaverPushed(sender: AnyObject) {
        if let url = NSURL(string: "http://map.naver.com/?dlevel=12&lat=37.7355941&lng=127.1350702&query=6rK96riw64%2BEIOuCqOyWkeyjvOyLnCDrs4TrgrTrqbQg7Jqp7JWU7KCc7LKt66eQ6ri4IDI2LTE0&type=ADDRESS&tab=1&enc=b64") {
            UIApplication.sharedApplication().openURL(url)
        }
    }

    @IBAction func DaumPushed(sender: AnyObject) {
        if let url = NSURL(string: "http://map.daum.net/?urlX=529763&urlY=1176648&q=%EA%B2%BD%EA%B8%B0+%EB%82%A8%EC%96%91%EC%A3%BC%EC%8B%9C+%EB%B3%84%EB%82%B4%EB%A9%B4+%EC%9A%A9%EC%95%94%EC%A0%9C%EC%B2%AD%EB%A7%90%EA%B8%B8+26-14") {
            UIApplication.sharedApplication().openURL(url)
        }
    }

}