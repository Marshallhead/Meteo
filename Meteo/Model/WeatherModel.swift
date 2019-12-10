//
//  WeatherModel.swift
//  Meteo
//
//  Created by Macbook on 10/12/2019.
//  Copyright © 2019 Marshall Lawal. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    //properties above are stored properties cos they store data
    var temperatureString: String{
        return String(format: "%.1f", temperature)// done to populate temperature label
    }
    var conditionName: String {// computed property
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
}
