//
//  SearchTableViewCell.swift
//  Weather
//
//  Created by Marian on 6/9/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation

protocol CitiesListPresenterProtocol : class{
    func getCitiesList()
    func delete(city: LMCityWeather)
}

protocol CitiesListViewProtocol : BaseViewProtocol{
    func setCitiesList(cities: [LMCityWeather]?)
}
