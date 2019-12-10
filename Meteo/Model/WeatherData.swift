//
//  WeatherData.swift
//  Meteo
//
//  Created by Macbook on 10/12/2019.
//  Copyright © 2019 Marshall Lawal. All rights reserved.
//

import Foundation

struct WeatherData: Codable {//codable means the weather data can adopt codable protocol to interprete(decode/encode) JSON data from external sources
    
    var name: String
    let main: Main
    var weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}
