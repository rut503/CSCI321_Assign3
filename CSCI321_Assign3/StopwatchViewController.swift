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
    
    @IBOutlet weak var playButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stopButtonOutlet: UIBarButtonItem!
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
    
        playButtonOutlet.isEnabled = false
        stopButtonOutlet.isEnabled = true
    }
    
    @IBAction func stopButton(_ sender: UIBarButtonItem) {
         timer.invalidate()
        timeFormatter(time: Int(stopwatchTimePicker.countDownDuration))
        stopButtonOutlet.isEnabled = false
        playButtonOutlet.isEnabled = true
        
    }
    
    @IBAction func timePickerAction(_ sender: UIDatePicker) {
        if (!timer.isValid) {
            timeFormatter(time: Int(stopwatchTimePicker.countDownDuration))
        }
    }
    
    @objc func decrementTimer(){
        
        timeLeft -= 1
        timeFormatter(time: timeLeft)
        
        if timeLeft <= 0 {
            timer.invalidate()
        }
        
    }
    
    func timeFormatter (time: Int) {
        var minutes: Int
        var seconds: Int
        
        minutes = Int (time) / 60 % 60
        seconds = Int(time) % 60
        
        timeLabel.text = String(format: "%02d:%02d",minutes,seconds)
    }
    
}

