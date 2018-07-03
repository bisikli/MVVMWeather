//
//  Weather.swift
//  MobvenWeather
//
//  Created by Bilgehan IŞIKLI on 3.07.2018.
//  Copyright © 2018 by. All rights reserved.
//

import Foundation

struct Weather : Codable {
    
    struct TemperatureDetails: Codable {
        let temp: Float
        let humidity : Float
    }
    
    struct WeatherDetails: Codable {
        let main: String
        let description: String
    }
    
    let main : TemperatureDetails
    let weather : [WeatherDetails]
    let dt_txt : String
}

struct WeatherList: Codable {
    
    let list: [Weather]
    
}
