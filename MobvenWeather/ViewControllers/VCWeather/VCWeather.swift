//
//  WeatherViewController.swift
//  MobvenWeather
//
//  Created by Bilgehan IŞIKLI on 3.07.2018.
//  Copyright © 2018 by. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class VCWeatherCell : UITableViewCell {
    
}

protocol VCWeatherDelegate: class {
    func didSelectTimeIntervalAtIndex(index: Int)
}

class VCWeather: UIViewController {
    
    weak var delegate : VCWeatherDelegate?
    
    private let bag = DisposeBag()
    
    private let cityLabel   = UILabel()
    private let weatherList = UITableView()
    
    var viewModel   : VCWeatherViewModel? = VCWeatherViewModel(withCity: "London")

    override func viewDidLoad() {
        
        setupViews()
        bindValues()
        
    }
    
    private func bindValues(){
        
        guard let viewModel = self.viewModel else { return }
        
        viewModel.cityName.asObservable().subscribe(onNext: { (name) in
            self.cityLabel.text = name
        }).disposed(by: bag)
        
        viewModel.weatherData.asObservable().bind(to: weatherList.rx.items(cellIdentifier: "VCWeatherCell", cellType: VCWeatherCell.self)) { index, weather, cell in
            
            guard let weatherInfo = weather.weather.first else { return }
            
            cell.textLabel?.text = "\(weather.dt_txt) : \(weatherInfo.main)"            
            
        }.disposed(by: bag)
        
    }

    private func setupViews(){
        
        weatherList.register(VCWeatherCell.classForCoder(), forCellReuseIdentifier: "VCWeatherCell")
        weatherList.delegate = self
        
        view.addSubview(cityLabel)
        view.addSubview(weatherList)
        
        cityLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(view.safeArea.top).offset(20)
            maker.left.equalTo(20)
            maker.height.equalTo(50)
        }
        
        weatherList.snp.makeConstraints { (maker) in
            maker.top.equalTo(cityLabel.snp.bottom).offset(20)
            maker.bottom.equalTo(view.safeArea.bottom)
            maker.right.left.equalTo(0)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? VCWeatherDetail, let details = sender as? Weather else { return }
        
        destination.viewModel = VCWeatherDetailViewModel(withCity: viewModel?.cityName.value, weather: details)
    }

}

extension VCWeather: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: Constants.weatherDetailSegueIdentifier, sender: viewModel?.weatherData.value[indexPath.row])
        
    }
    
}
