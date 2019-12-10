//
//  ViewController.swift
//  Meteo
//
//  Created by Macbook on 07/12/2019.
//  Copyright © 2019 Marshall Lawal. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate , CLLocationManagerDelegate{ //UITextfieldDelegate allows validation of text in textfield

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    @IBOutlet weak var SearchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()// responsible for getting current GPS LOCATION of the user
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self//sets the class(weatherviewmanager) as delegate to handle location data..important to call this first before request location or app crashes

        locationManager.requestWhenInUseAuthorization()// in addition, go to info.plist and add privacy location when in use auth to tell user why we need their location
        locationManager.requestLocation()
        
        
        
        
        
        weatherManager.delegate = self// allows weathermanager to notify viewcontroller of data

        SearchTextField.delegate = self// allows textfield to notify viewcontroller
        
    }
    //MARK: - Location Manager Delegate
    
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Got location")
        if let location = locations.last { //fetch most accurate current location in the array[cllocations]
            locationManager.stopUpdatingLocation()// needed so location can be requested again
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)

        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    //MARK: - UITextFieldDelegate

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
    //MARK: - WeatherManagerDelegate
    
    func didUpdateWeather(weather: WeatherModel) {
        print(weather.temperature)
        DispatchQueue.main.async {//needed to put method on main thread otherwise app freezes
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

