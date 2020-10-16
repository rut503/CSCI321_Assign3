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
    
    var unitToConvertFrom = "F"        // flag to keep tract of which conversion is needed
    let fahrenheitValues: [Int] = Array(-129...134) // possible fahrenheit temp values to convert from
    let celsiusValues: [Int] = Array(-90...57) // possible celsius temp values to convert from
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initial conversion to display when app loads.
        convertFahrenheitToCelsius(fahrenheits: fahrenheitValues[tempAmountPicker.selectedRow(inComponent: 0)])
    }
    
    /**
     This function sets converison flag which indicates which type of conversion is needed according to the Segment choosen by the user and then does
     the initial conversion based on the first row value in the temp data picker.
     */
    @IBAction func unitsOfConversionPicked(_ sender: UISegmentedControl) {
        // selectes first row from the data picker to avoid index out of bounds.
        tempAmountPicker.selectRow(0, inComponent: 0, animated: true)
        
        // if the user chose to convert F to C
        if(sender.selectedSegmentIndex == 0){
            unitToConvertFrom = "F"   // set the flag
            // initial conversion based on the first row of the data picker.
            convertFahrenheitToCelsius(fahrenheits: fahrenheitValues[tempAmountPicker.selectedRow(inComponent: 0)])
        }
        // if the user chose to convert C to F
        else {
            unitToConvertFrom = "C"   // set the flag
            // initial conversion based on the first row of the data picker.
            convertCelsiusToFahrenheit(celsius: celsiusValues[tempAmountPicker.selectedRow(inComponent: 0)])
        }
        
        tempAmountPicker.reloadAllComponents() // reload the component so that new temp data shows in the data picker
    }
    
    // MARK: Picker View Data Source methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // using one component for data picker
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // if the Picker asks for number of rows in Fahrenheit data array
        if(unitToConvertFrom == "F"){
            return fahrenheitValues.count
        }
        // if the Picker asks for number of rows in Celsius data array
        else {
            return celsiusValues.count
        }
    }

    // MARK: Picker View Delegate method
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // returning data for Fahrenheit data picker
        if(unitToConvertFrom == "F"){
            return String(fahrenheitValues[row])
        }
        // returning data for Celsius data picker
        else{
            return String(celsiusValues[row])
        }
    }
    
    /**
     This function runs when user selects a row in the data picker and converts the selected temparate from desired unit to another unit.
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // if the temp picked is Fahrenheit
        if(unitToConvertFrom == "F"){
            // convert Fahrenheit amount to Celsius amount.
            convertFahrenheitToCelsius(fahrenheits: fahrenheitValues[row])
        }
        // if the temp picked is Celsius
        else{
            // convert Celsius amount to Fahrenheit amount.
            convertCelsiusToFahrenheit(celsius: celsiusValues[row])
        }
    }
    
    /**
     This function converts Fahrenheit Temp to Celsius Temp and displays result on a label.
     */
    func convertFahrenheitToCelsius(fahrenheits: Int) {
        // F to C conversion formula
        let temp = Int((Double(fahrenheits) - 32.0) * (5.0 / 9.0))
        // display the result
        convertedValueLabel.text = String(temp) + "°C"
    }
    
    /**
     This function converts Celsius Temp to Fahrenheit Temp and displays result on a label.
    */
    func convertCelsiusToFahrenheit(celsius: Int) {
        // C to F conversion formula
        let temp = Int((Double(celsius) * 9.0 / 5.0) + 32)
        // display the result
        convertedValueLabel.text = String(temp) + "°F"
    }
}
