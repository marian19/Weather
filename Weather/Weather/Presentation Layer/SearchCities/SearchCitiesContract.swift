//
//  SearchTableViewCell.swift
//  Weather
//
//  Created by Marian on 6/9/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation

protocol SearchCitiesPresenterProtocol : class{
    
    func searchCities(keyword: String)
    func save(city: City)
}

protocol SearchCitiesViewProtocol : BaseViewProtocol{
    
    func setCities(cities: [City])
}
