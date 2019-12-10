//
//  WeatherManager.swift
//  Meteo
//
//  Created by Macbook on 10/12/2019.
//  Copyright © 2019 Marshall Lawal. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {//created to be able to send info PARSED by the JSON and converted to strings in the weathermodel to the VC
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error: Error)
}
struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=492acf07b380bfb1657b3d0a5dccd981&units=metric"
    
    var delegate: WeatherManagerDelegate?//
    
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
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {//safedata to unwrap the data got from the session
                    if let weather = self.parseJSON(weatherData: safeData) {// parseJSON to decode the JavaScriptObjectNotation data into swift..send weather object containing decodedData by JSONdecoder and turned into a string by the weathermodel to the viewController
                        self.delegate?.didUpdateWeather(weather: weather)// works cos deletegate is of type WeathermanagerDelegate protocol that requires the didupdateWeather method
                        
                    }
                }
            }
            //4. START TASK
            task.resume()
            
        }
        
    }
    func parseJSON(weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self/*.self allow to specify the dataType*/, from: weatherData)
            //print(decodedData.weather[0].id)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather// weather object to get data used to populate UI in SFsymbol image based on Id, change cityLabel and temp label. send this data back to the parse json to become safe data use to populate UIViews and its output will be the weatherModel datatype..returns nil if theres an error so its optional
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }


    }
    

