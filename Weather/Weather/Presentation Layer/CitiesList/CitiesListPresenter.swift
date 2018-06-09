//
//  SearchTableViewCell.swift
//  Weather
//
//  Created by Marian on 6/9/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation

class CitiesListPresenter: CitiesListPresenterProtocol{
    
    weak var view: CitiesListViewProtocol?
    
    required init(view: CitiesListViewProtocol) {
        self.view = view
    }
    
    func getCitiesList() {
        
        WeatherRepository.sharedInstance.getAllCities { (cities, error) in
            
            if error == nil {
            self.view?.setCitiesList(cities: cities)
            }else{
                self.view?.showMsg(msg: error!)
            }
        }
    }
    
    func delete(city: LMCityWeather){
        CoreDataManager.sharedInstance.managedObjectContext.delete(city)
        CoreDataManager.sharedInstance.saveContext()
    }
    
    
}
