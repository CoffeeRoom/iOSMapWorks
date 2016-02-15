//
//  ReservationViewController.swift
//  TrailsAlpha
//
//  Created by Yoon on 2016. 2. 14..
//  Copyright © 2016년 Yoonseung Choi. All rights reserved.
//

import UIKit

class ReservationViewController: UIViewController {
    
    
    @IBOutlet weak var LabelNumOfAdult: UILabel!
    @IBOutlet weak var LabelNumOfElder: UILabel!
    @IBOutlet weak var LabelNumOfYoung: UILabel!
    @IBOutlet weak var LabelNumOfChild: UILabel!
    
    
    @IBOutlet weak var numberOfAdult: UIStepper!
    @IBAction func StepperForAdult(sender: UIStepper) {
        LabelNumOfAdult.text = Int(sender.value).description + " 명"
    }
    
    
    @IBOutlet weak var numberOfElder: UIStepper!
    @IBAction func StepperForElder(sender: UIStepper) {
        LabelNumOfElder.text =  Int(sender.value).description + " 명"
    }
    

    @IBOutlet weak var numberOfYoung: UIStepper!
    @IBAction func StepperForYoung(sender: UIStepper) {
        LabelNumOfYoung.text =  Int(sender.value).description + " 명"
    }
    
    @IBOutlet weak var numberOfChild: UIStepper!
    @IBAction func StepperForChild(sender: UIStepper) {
        LabelNumOfChild.text = Int(sender.value).description + " 명"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let people = [numberOfAdult, numberOfElder, numberOfYoung, numberOfChild]
        
        for p in people {
            p.wraps = false
            p.autorepeat = true
            p.minimumValue = 0
            p.maximumValue = 10
            p.value = 0
        }
        
    }
    
    
}

// ref - stepper
// http://www.ioscreator.com/tutorials/uistepper-tutorial-ios8-swift