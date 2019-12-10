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
            
            let session = URLSession(configuration: .default)// URLSession is like a browser, its what does the networking
            
            //3. GIVE URLSession a task
            let task = session.dataTask(with: url) { (data, response, error) in//session retrieves contents of the URL
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {//safedata to unwrap the data got from the session
                    self.parseJSON(weatherData: safeData)// parseJSON to decode the JavaScriptObjectNotation data into swift
                }
            }
            //4. START TASK
            task.resume()
            
        }
        
    }
    func parseJSON(weatherData: Data) {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self/*.self allow to specify the dataType*/, from: weatherData)
            //print(decodedData.weather[0].id)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)// weather object to get data used to populate UI in SFsymbol image based on Id, change cityLabel and temp label
            print(weather.conditionName)
        } catch {
            print(error)
        }
    }

    }
    

