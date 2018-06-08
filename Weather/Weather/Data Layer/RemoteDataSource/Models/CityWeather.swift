//
//  CityWeather.swift
//  Weather
//
//  Created by Marian on 6/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation

struct CityWeather : Codable {
    
    let list : [List]?
    let city : CityInfo?
    enum CodingKeys: String, CodingKey {
        
        case list = "list"
        case city
    }
    
}
