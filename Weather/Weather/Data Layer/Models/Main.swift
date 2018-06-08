

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
    let temp_min : Double?
    let temp_max : Double?
    let pressure : Double?
    let sea_level : Double?
    let grnd_level : Double?
    let humidity : Int?
    let temp_kf : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case temp = "temp"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case pressure = "pressure"
        case sea_level = "sea_level"
        case grnd_level = "grnd_level"
        case humidity = "humidity"
        case temp_kf = "temp_kf"
    }
    
}
