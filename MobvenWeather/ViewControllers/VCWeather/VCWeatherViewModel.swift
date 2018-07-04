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
    
    private let bag = DisposeBag()
    private let downloader  = Downloader()
    
    var networkOperationOnError: ((Error) -> Void)?
    
    let cityName    : Variable<String>      = Variable("")
    let weatherData : Variable<[Weather]>   = Variable([])
    let networkOperationInProgress: Variable<Bool> = Variable(false)
    
    init(){
        
        cityName.asObservable().skip(1).subscribe(onNext: { (newName) in
            
            self.networkOperationInProgress.value = true
            self.downloader.downloadWeather(withCityName: newName, completionHandler: { (weatherData, error) in
                
                self.networkOperationInProgress.value = false
                guard error == nil, let weatherData = weatherData else {
                    self.weatherData.value = []
                    self.networkOperationOnError?(error!)
                    return
                }
                
                
                self.weatherData.value = weatherData
                
            })
            
        }).disposed(by: bag)
        
        
        
    }
    
    convenience init(withCity city: String){
        self.init()
        
        cityName.value = city
    }
    
    
}
