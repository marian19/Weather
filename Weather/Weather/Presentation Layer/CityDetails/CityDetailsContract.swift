//
//  SearchTableViewCell.swift
//  Weather
//
//  Created by Marian on 6/9/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation

protocol CityDetailsPresenterProtocol : class{
    func getCityDetails(name: String)
}

protocol CityDetailsViewProtocol : BaseViewProtocol{
    func setCityDetails(info: [LMCityInfo]?)
}
