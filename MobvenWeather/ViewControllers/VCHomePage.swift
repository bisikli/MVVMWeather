//
//  VCHomePage.swift
//  MobvenWeather
//
//  Created by Bilgehan IŞIKLI on 4.07.2018.
//  Copyright © 2018 by. All rights reserved.
//

import UIKit

class VCHomePage: UIViewController {
    
    private let childSegue          = "VCWeather"
    private let navigationSegue     = "VCWeatherDetail"
    
    private var weatherVC : VCWeather!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case childSegue:
            
            guard let destination = segue.destination as? VCWeather else { return }
            
            weatherVC = destination
            weatherVC.delegate = self
        
        case navigationSegue:
            
            guard let destination = segue.destination as? VCWeatherDetail, let details = sender as? Weather.TemperatureDetails else { return }
            
            destination.viewModel = VCWeatherDetailViewModel(details: details )
            
        default:
            print("No segue")
        }
    }
    

}

extension VCHomePage : VCWeatherDelegate {
    
    func didSelectTimeIntervalAtIndex(index: Int) {
        performSegue(withIdentifier: navigationSegue, sender: weatherVC.viewModel?.weatherData.value[index].main)
    }
    
}

extension VCHomePage : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        searchBar.resignFirstResponder()
        weatherVC.viewModel?.cityName.value = searchText
        
        NotificationCenter.default.post(name: Constants.newSearchNotification, object: searchText)
        
    }
    
}
