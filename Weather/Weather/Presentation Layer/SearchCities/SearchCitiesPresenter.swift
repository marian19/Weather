//
//  SearchTableViewCell.swift
//  Weather
//
//  Created by Marian on 6/9/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation

class SearchCitiesPresenter: SearchCitiesPresenterProtocol{
    
    weak var view: SearchCitiesViewProtocol?
    
    required init(view: SearchCitiesViewProtocol) {
        self.view = view
    }
    
    func searchCities(keyword: String){
        
        if keyword.isValidCityName{
            WeatherRepository.sharedInstance.findCity(cityName: keyword) { (result, error) in
                if error == nil {
                    self.view?.setCities(cities: (result?.list!)!)
                }else{
                    self.view?.showMsg(msg: error!)
                }
            }
        }else{
            view?.showMsg(msg: "invalid_city_name".localized())
        }
    }
    
    func save(city: City){
        let msg = WeatherRepository.sharedInstance.saveCityToCoreData(city: city)
        self.view?.showMsg(msg: msg)
    }
}
