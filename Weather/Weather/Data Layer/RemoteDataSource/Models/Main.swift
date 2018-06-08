//
//  Main.swift
//  Weather
//
//  Created by Marian on 6/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//
import Foundation

struct Main : Codable {
    
    let temp : Double?
    let tempMin : Double?
    let tempMax : Double?
    let pressure : Double?
    let seaLevel : Double?
    let grndLevel : Double?
    let humidity : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case temp = "temp"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity = "humidity"
    }
    
}
