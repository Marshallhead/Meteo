//
//  WeatherData.swift
//  Meteo
//
//  Created by Macbook on 10/12/2019.
//  Copyright © 2019 Marshall Lawal. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    
    var name: String
    let main: Main
    var weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
}
