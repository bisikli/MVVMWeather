//
//  VCWeatherDetailViewModel.swift
//  MobvenWeather
//
//  Created by Bilgehan IŞIKLI on 4.07.2018.
//  Copyright © 2018 by. All rights reserved.
//

import Foundation
import RxSwift

class VCWeatherDetailViewModel {
    
    let detailModel: Variable<Weather.TemperatureDetails> = Variable(Weather.TemperatureDetails())
    
    init(details: Weather.TemperatureDetails){
        
        detailModel.value = details
        
    }
    
}
