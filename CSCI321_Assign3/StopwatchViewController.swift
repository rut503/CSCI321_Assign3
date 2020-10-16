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
    @IBOutlet weak var pauseButtonOutlet: UIBarButtonItem!
    
    var timeLeft = 60       //initial value 1 min
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pauseButtonOutlet.isEnabled = false            //disabling pause button
        stopButtonOutlet.isEnabled = false             //disabling stop button
    }
    
    /**
     Play button which starts the clock and decrement the time by calling "decreamentTimer". It also enables pause and stop buttons.
     */
    @IBAction func startButton(_ sender: UIBarButtonItem) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decrementTimer), userInfo: nil, repeats: true)
        playButtonOutlet.isEnabled = false       //disables play button
        pauseButtonOutlet.isEnabled = true       //enables pause button
        stopButtonOutlet.isEnabled = true        //enables stop button
    }
    
    /**
     Pause button to pause the timer. It also enables the play button once we pause the timer.
     */
    @IBAction func pauseButton(_ sender: UIBarButtonItem) {
        timer.invalidate()                      //pause timer
        pauseButtonOutlet.isEnabled = false     //disables pause button
        playButtonOutlet.isEnabled = true       // enables play button
        
    }
    
    /**
     Stop button to Reset the timer when clicked. This button is enabled when clock is running.
     */
    @IBAction func stopButton(_ sender: UIBarButtonItem) {
        timer.invalidate()  // stop the timer
        timeLeft = Int(stopwatchTimePicker.countDownDuration)    // reset the timer to value selected
        timeFormatter(time: Int(stopwatchTimePicker.countDownDuration))
        stopButtonOutlet.isEnabled = false      //disables stop button
        pauseButtonOutlet.isEnabled = false     //disables pause button
        playButtonOutlet.isEnabled = true       //enalbes play button
    }
    
    /**
     Updates the time clock as we select the time from UI Time Picker
     */
    @IBAction func timePickerAction(_ sender: UIDatePicker) {
        // if the timer is stopped then allow time picker to count down time
        if (!timer.isValid) {
            timeLeft = Int(stopwatchTimePicker.countDownDuration) // resetting timer
            timeFormatter(time: Int(sender.countDownDuration))    // printing new time
        }
    }
    
    /**
     Calculates time left, by decrement it by one second each and simultaneously printing it out timeFormatter()
     */
    @objc func decrementTimer(){
        timeLeft -= 1                   // descrease time by 1 second
        timeFormatter(time: timeLeft)   // print the time in time format
        
        // if the count down hits 0, stop the timer.
        if timeLeft <= 0 {
            timer.invalidate()
        }
    }
    
    /**
     Prints out the stopwatch time in right format i.e., in hours, minutes and seconds ( HH:MM:SS )
     */
    func timeFormatter (time: Int) {
        var hours: Int
        var minutes: Int
        var seconds: Int
        
        hours = Int(time) / 60 / 60 % 60
        minutes = Int(time) / 60 % 60
        seconds = Int(time) % 60
        
        timeLabel.text = String(format: "%02d:%02d:%02d",hours,minutes,seconds)
    }
    
}

