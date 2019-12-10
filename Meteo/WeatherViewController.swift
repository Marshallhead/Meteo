//
//  ViewController.swift
//  Meteo
//
//  Created by Macbook on 07/12/2019.
//  Copyright © 2019 Marshall Lawal. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate { // allows validation of text in textfield

    @IBOutlet weak var ConditionImageView: UIImageView!
    @IBOutlet weak var TemperatureLabel: UILabel!
    @IBOutlet weak var CityLabel: UILabel!
    
    
    @IBOutlet weak var SearchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SearchTextField.delegate = self// allows textfield to notify viewcontroller
    }

    @IBAction func locationPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        SearchTextField.endEditing(true)//dismisses keyboard
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {// what happens when the return/search/go button pressed
        SearchTextField.endEditing(true)//dismisses keyboard
        return true
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {// validate what user types
        
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "type Something"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        // Use search Textfield.text to get the weather
        if let city = SearchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        SearchTextField.text = ""// clears searchtextfield after search/go is pressed 
    }
}

