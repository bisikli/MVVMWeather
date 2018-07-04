//
//  VCWeatherDetail.swift
//  MobvenWeather
//
//  Created by Bilgehan IŞIKLI on 4.07.2018.
//  Copyright © 2018 by. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift




class VCWeatherDetail: UIViewController {
    
    private let bag = DisposeBag()
    
    let cityLabel  = UILabel()
    
    private let temp     = UILabel()
    private let temp_max = UILabel()
    private let temp_min = UILabel()
    private let pressure = UILabel()
    private let humidity = UILabel()
    
    var viewModel : VCWeatherDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindComponents()
        
        
    }
    
    private func bindComponents(){
        
        guard let viewModel = self.viewModel else { return }
        
        viewModel.detailModel.asObservable().subscribe(onNext: { (details) in
            
            self.temp.text       = "\(details.temp)"
            self.temp_max.text   = "\(details.temp_max)"
            self.temp_min.text   = "\(details.temp_min)"
            self.humidity.text   = "\(details.humidity)"
            self.pressure.text   = "\(details.pressure)"
            
        }).disposed(by: bag)
        
        viewModel.title.asObservable().subscribe(onNext: { (title) in
            self.cityLabel.text = title
        }).disposed(by: bag)
        
    }
    
    private func setupViews(){
        
        view.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(view.safeArea.top).offset(10)
            maker.left.equalTo(10)
            maker.height.equalTo(50)
        }
        
        let detailStack = Builder.createVerticalStack(with: [Builder.createTitledRow(with: "Temperature", content: temp),
                                                             Builder.createTitledRow(with: "Max Temperature", content: temp_max),
                                                             Builder.createTitledRow(with: "Min Temperature", content: temp_min),
                                                             Builder.createTitledRow(with: "Pressure", content: pressure),
                                                             Builder.createTitledRow(with: "Humidity", content: humidity)])
        
        view.addSubview(detailStack)
        
        detailStack.snp.makeConstraints { (maker) in
            maker.left.equalTo(10)
            maker.right.equalTo(-10)
            maker.top.equalTo(cityLabel.snp.bottom).offset(20)
            maker.height.equalTo(view.snp.height).dividedBy(2)
        }
        
    }


}
