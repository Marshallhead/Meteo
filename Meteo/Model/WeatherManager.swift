//
//  WeatherManager.swift
//  Meteo
//
//  Created by Macbook on 10/12/2019.
//  Copyright © 2019 Marshall Lawal. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=492acf07b380bfb1657b3d0a5dccd981&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    //NETWORKING
    
    func performRequest(urlString: String){
        //1. CREATE A URL
        if let url = URL(string: urlString) {
            //2. CREATE A URL SESSION
            
            let session = URLSession(configuration: .default)
            
            //3. GIVE URLSession a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)// utf8 a standardized protocol for encoding text in websites
                }
            }
            //4. START TASK
            task.resume()
            
        }
        
    }
    func parseJSON(weatherData: Data) {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
        } catch {
            print(error)
        }
    }
    
    
}
