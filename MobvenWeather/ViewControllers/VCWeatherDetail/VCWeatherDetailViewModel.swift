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
    
    let title : Variable<String> = Variable("")
    let detailModel: Variable<Weather.TemperatureDetails> = Variable(Weather.TemperatureDetails())
    
    init(withCity name: String?, weather details: Weather){
        
        detailModel.value = details.main
        title.value    = "\(name ?? "") - \(details.dt_txt)"
    }
    
}
