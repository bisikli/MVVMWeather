//
//  HistoryManager.swift
//  MobvenWeather
//
//  Created by Bilgehan IŞIKLI on 4.07.2018.
//  Copyright © 2018 by. All rights reserved.
//

import Foundation
import RxSwift

class HistoryManager {
    
    let history : Variable<[String]> = Variable([])
    
    init() {
    
        NotificationCenter.default.addObserver(self, selector: #selector(newSearch(notification:)), name: Constants.newSearchNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(save), name: Constants.applicationWillTerminateNotification, object: nil)
        
        if let existingHistory = UserDefaults.standard.value(forKey: Constants.citySearchHistory) as? [String] {
            history.value = existingHistory
        }
        
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func newSearch(notification: NSNotification) {
        if let city = notification.object as? String {
            history.value.append(city)
        }
    }
    
    @objc func save(){
        
        UserDefaults.standard.setValue(history.value, forKey: Constants.citySearchHistory)
        UserDefaults.standard.synchronize()
        
    }
    
}
