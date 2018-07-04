//
//  VCHomePage.swift
//  MobvenWeather
//
//  Created by Bilgehan IŞIKLI on 4.07.2018.
//  Copyright © 2018 by. All rights reserved.
//

import UIKit

class VCHomePage: UIViewController {

    
    private var weatherVC : VCWeather!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self

    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case Constants.weatherSegueIdentifier:
            
            guard let destination = segue.destination as? VCWeather else { return }
            
            weatherVC = destination
        
        default:
            fatalError("No such segue")
        }
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
