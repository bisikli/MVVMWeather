//
//  VCWeatherViewModel.swift
//  MobvenWeather
//
//  Created by Bilgehan IŞIKLI on 3.07.2018.
//  Copyright © 2018 by. All rights reserved.
//

import Foundation
import RxSwift

class VCWeatherViewModel {
    
    let bag = DisposeBag()
    
    let downloader  = Downloader()
    
    let cityName    : Variable<String>      = Variable("")
    let weatherData : Variable<[Weather]>   = Variable([])
    
    init(){
        
        cityName.asObservable().skip(1).subscribe(onNext: { (newName) in
            
            self.downloader.downloadWeather(withCityName: newName, completionHandler: { (weatherData, error) in
                
                if let weatherData = weatherData {
                    self.weatherData.value = weatherData
                }
                
            })
            
        }).disposed(by: bag)
        

    }
    
    convenience init(withCity city: String){
        self.init()
        
        cityName.value = city
    }
    
    
}
