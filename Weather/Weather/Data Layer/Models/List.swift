//
//  List.swift
//  Weather
//
//  Created by Marian on 6/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation

struct List : Codable {
    
    let dt : Int?
    let main : Main?
    let weather : [Weather]?
    let dt_txt : String?
    
    enum CodingKeys: String, CodingKey {
        
        case dt = "dt"
        case main
        case weather = "weather"
        case dt_txt = "dt_txt"
    }
    
}
