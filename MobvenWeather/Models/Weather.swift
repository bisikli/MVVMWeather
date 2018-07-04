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
        let temp_max : Float
        let temp_min : Float
        let humidity : Float
        let pressure : Float
        
        init(){
            temp     = 0
            temp_max = 0
            temp_min = 0
            humidity = 0
            pressure = 0
        }
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
