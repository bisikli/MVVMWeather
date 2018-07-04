//
//  VCHistory.swift
//  MobvenWeather
//
//  Created by Bilgehan IŞIKLI on 4.07.2018.
//  Copyright © 2018 by. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class VCHistoryCell : UITableViewCell {
    
}

class VCHistory: UIViewController {

    private let bag = DisposeBag()
    private let historyManager = VCHistoryViewModel()
    
    let historyTable = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindComponents()
        
        
    }
    
    private func bindComponents(){
        
        historyManager.history.asObservable().bind(to: historyTable.rx.items(cellIdentifier: Constants.historyCellReuseIdentifier, cellType: VCHistoryCell.self)) { index, history, cell in
            
            cell.textLabel?.text = history
            
            }.disposed(by: bag)
        
    }
    
    private func setupViews(){
        
        historyTable.register(VCHistoryCell.classForCoder(), forCellReuseIdentifier: Constants.historyCellReuseIdentifier)
        historyTable.tableFooterView = UIView()
        historyTable.delegate = self
        
        view.addSubview(historyTable)
        historyTable.snp.makeConstraints { (maker) in
            maker.top.equalTo(view.safeArea.top).offset(30)
            maker.left.equalTo(10)
            maker.right.equalTo(-10)
            maker.bottom.equalTo(view.safeArea.bottom).offset(-20)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let destination = segue.destination as? VCWeather, let city = sender as? String else { return }
        
        destination.viewModel = VCWeatherViewModel(withCity: city)
        
    }


}

extension VCHistory : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let city = historyManager.history.value[indexPath.row]
        
        performSegue(withIdentifier: Constants.weatherSegueIdentifier, sender: city)
        
    }
    
}
