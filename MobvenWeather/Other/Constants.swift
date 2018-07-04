//
//  Constants.swift
//  MobvenWeather
//
//  Created by Bilgehan IŞIKLI on 4.07.2018.
//  Copyright © 2018 by. All rights reserved.
//

import Foundation

enum Constants {
    
    static let applicationWillTerminateNotification = NSNotification.Name.init("applicationWillTerminateNotification")
    static let newSearchNotification = NSNotification.Name.init("newSearchNotification")
    
    static let citySearchHistory = "citySearchHistory"
    
    
    static let historyCellReuseIdentifier = "historyCellReuseIdentifier"
    
    static let weatherSegueIdentifier = "VCWeather"
    static let weatherDetailSegueIdentifier = "VCWeatherDetail"
}
