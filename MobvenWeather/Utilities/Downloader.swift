//
//  Downloader.swift
//  MobvenWeather
//
//  Created by Bilgehan IŞIKLI on 3.07.2018.
//  Copyright © 2018 by. All rights reserved.
//

import Foundation

enum APIError: Error {
    
    case error(reason: String)
    
}

extension APIError : LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .error(let reason):
            return reason
        }
    }
    
}



class Downloader {
    
    
    func downloadWeather(withCityName city: String, completionHandler: @escaping ([Weather]?, Error?) -> Void){
        
        let endpoint = "http://api.openweathermap.org/data/2.5/forecast?q=\(city)&units=metric&APPID=8827fbf408dc7e1418f3c1e84596334c"
        
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            let error = APIError.error(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(nil, APIError.error(reason: "Did not receive data"))
                return
            }
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let weatherData = try decoder.decode(WeatherList.self, from: responseData)
                completionHandler(weatherData.list, nil)
            } catch {
                completionHandler(nil, APIError.error(reason: "error trying to convert data to JSON"))
            }
        }
        task.resume()
        
    }
    
    
}
