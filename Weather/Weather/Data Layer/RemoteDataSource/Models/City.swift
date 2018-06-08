//
//  City.swift
//  Weather
//
//  Created by Marian on 6/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation

struct City : Codable {
    
    let id : Int?
    let name : String?
    let main : Main?
    let dt : Int?
    let wind : Wind?
    let sys : Sys?
    let rain : String?
    let snow : String?
    let weather : [Weather]?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case main = "main"
        case dt = "dt"
        case wind
        case sys
        case rain = "rain"
        case snow = "snow"
        case weather = "weather"
    }
    
}
