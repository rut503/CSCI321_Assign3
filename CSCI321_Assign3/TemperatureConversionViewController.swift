//
//  TemperatureConversionViewController.swift
//  CSCI321_Assign3
//
//  Created by Rutvik Patel  : Z1865128
//  Created by Aviraj Parmar : Z1861160
//
//  Copyright © 2020 Rut Codes. All rights reserved.
//

import UIKit

class TemperatureConversionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var unitsOfConversion: UISegmentedControl!
    
    @IBOutlet weak var tempAmountPicker: UIPickerView!
    
    @IBOutlet weak var convertedValueLabel: UILabel!
    
    var unitToConvertFrom = "F"
    
    let fahrenheitValues: [Int] = Array(-129...134)
    let celsiusValues: [Int] = Array(-90...57)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        convertFahrenheitToCelsius(fahrenheits: fahrenheitValues[tempAmountPicker.selectedRow(inComponent: 0)])
    }
    
    
    @IBAction func unitsOfConversionPicked(_ sender: UISegmentedControl) {
        tempAmountPicker.selectRow(0, inComponent: 0, animated: true)
        
        if(sender.selectedSegmentIndex == 0){
            unitToConvertFrom = "F"
            convertFahrenheitToCelsius(fahrenheits: fahrenheitValues[tempAmountPicker.selectedRow(inComponent: 0)])
        }
        else {
            unitToConvertFrom = "C"
            convertCelsiusToFahrenheit(celsius: celsiusValues[tempAmountPicker.selectedRow(inComponent: 0)])
        }
        
        tempAmountPicker.reloadAllComponents()
    }
    
    // MARK: Picker View Data Source methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(unitToConvertFrom == "F"){
            return fahrenheitValues.count
        }
        else {
            return celsiusValues.count
        }
    }

    // MARK: Picker View Delegate method
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(unitToConvertFrom == "F"){
            return String(fahrenheitValues[row])
        }
        else{
            return String(celsiusValues[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(unitToConvertFrom == "F"){
            convertFahrenheitToCelsius(fahrenheits: fahrenheitValues[row])
        }
        else{
            convertCelsiusToFahrenheit(celsius: celsiusValues[row])
        }
    }
    
    func convertFahrenheitToCelsius(fahrenheits: Int) {
        let temp = Int((Double(fahrenheits) - 32.0) * (5.0 / 9.0))
        convertedValueLabel.text = String(temp) + "°C"
    }
    
    func convertCelsiusToFahrenheit(celsius: Int) {
        let temp = Int((Double(celsius) * 9.0 / 5.0) + 32)
        convertedValueLabel.text = String(temp) + "°F"
    }
}
