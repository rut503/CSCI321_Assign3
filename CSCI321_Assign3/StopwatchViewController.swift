//
//  StopwatchViewController.swift
//  CSCI321_Assign3
//
//  Created by Rutvik Patel  : Z1865128
//  Created by Aviraj Parmar : Z1861160
//
//  Copyright © 2020 Rut Codes. All rights reserved.
//

import UIKit

class StopwatchViewController: UIViewController {
    
    @IBOutlet weak var stopwatchTimePicker: UIDatePicker!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var timeLeft = 60
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        self.touch.isEnabled = false
    }
    
    @IBAction func startButton(_ sender: UIBarButtonItem) {
        timeLeft = Int(stopwatchTimePicker.countDownDuration)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decrementTimer), userInfo: nil, repeats: true)
        
        sender.isEnabled = false
    }
    
    @IBAction func stopButton(_ sender: UIBarButtonItem) {
         timer.invalidate()
    }
    
    @objc func decrementTimer(){
        
        var minutes: Int
        var seconds: Int
        timeLeft -= 1
        
        minutes = Int (timeLeft) / 60 % 60
        seconds = Int(timeLeft) % 60
        
        timeLabel.text = String(format: "%02d:%02d",minutes,seconds)
        
        if timeLeft <= 0 {
            timer.invalidate()
        }
        
    }
    
}

