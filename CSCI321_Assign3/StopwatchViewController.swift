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
    var timeLeft = 60                       //initial value 1 min
    var timer = Timer()
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timeFormatter(time: timeLeft)                  //print out initial time
        pauseButtonOutlet.isEnabled = false            //disabling pause button
        stopButtonOutlet.isEnabled = false             //disabling stop button
    }
    
    /**
     Play button which starts the clock and decrement the time by calling "decreamentTimer". It also enables pause and stop buttons.
     */
    @IBAction func startButton(_ sender: UIBarButtonItem) {
        
        if ( !flag ) {   //only reset the clock the first time
            timeLeft = Int(stopwatchTimePicker.countDownDuration)
        }
        flag = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decrementTimer), userInfo: nil, repeats: true)
        
        playButtonOutlet.isEnabled = false       //disables play button
        pauseButtonOutlet.isEnabled = true       //enables pause button
        stopButtonOutlet.isEnabled = true        //enables stop button
    }
    
    /**
     Pause button to pause the timer. It also enables the play button once we pause the timer.
     */
    @IBAction func pauseButton(_ sender: UIBarButtonItem) {
        timer.invalidate()
        pauseButtonOutlet.isEnabled = false     //disables pause button
        playButtonOutlet.isEnabled = true       // enables play button
        flag = true
    }
    
    /**
     Stop button to Reset the timer when clicked. This button is enabled when clock is running.
     */
    @IBAction func stopButton(_ sender: UIBarButtonItem) {
        timer.invalidate()
        timeLeft = Int(stopwatchTimePicker.countDownDuration)
        timeFormatter(time: Int(stopwatchTimePicker.countDownDuration))
        stopButtonOutlet.isEnabled = false      //disables stop button
        playButtonOutlet.isEnabled = true       //enalbes play button
    }
    
    /**
     Updates the time clock as we select the time in stop watch
     */
    @IBAction func timePickerAction(_ sender: UIDatePicker) {
        if (!timer.isValid && !flag) {
            timeFormatter(time: Int(stopwatchTimePicker.countDownDuration))
        }
    }
    
    /**
     Calculates time left, by decrement it by one second each and simultaneously printing it out timeFormatter()
     */
    @objc func decrementTimer(){
        
        timeLeft -= 1
        timeFormatter(time: timeLeft)
        
        if timeLeft <= 0 {
            timer.invalidate()
        }
        
    }
    
    /**
     Prints out the stopwatch time in right format i.e., in minutes and seconds ( MM:SS )
     */
    func timeFormatter (time: Int) {
        var minutes: Int
        var seconds: Int
        
        minutes = Int (time) / 60 % 60
        seconds = Int(time) % 60
        
        timeLabel.text = String(format: "%02d:%02d",minutes,seconds)
    }
    
}

