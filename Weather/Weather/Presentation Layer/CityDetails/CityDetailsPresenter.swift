//
//  SearchTableViewCell.swift
//  Weather
//
//  Created by Marian on 6/9/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation

class CityDetailsPresenter: CityDetailsPresenterProtocol{
    
    weak var view: CityDetailsViewProtocol?
    required init(view: CityDetailsViewProtocol) {
        self.view = view
    }
    
    func getCityDetails(name: String) {
        
        WeatherRepository.sharedInstance.getCityWeather(cityName: name) { (result, error) in
            
            if error == nil{
                let info: [LMCityInfo] = result?.list?.allObjects as! [LMCityInfo]
                self.view?.setCityDetails(info: info)
            }else{
                self.view?.showMsg(msg: error!)
            }
        }
    }
}
