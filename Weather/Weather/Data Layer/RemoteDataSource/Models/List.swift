//
//  List.swift
//  Weather
//
//  Created by Marian on 6/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation

struct List : Codable {
    
    let date : Int?
    let main : Main?
    let weather : [Weather]?
    let dateText : String?
    
    enum CodingKeys: String, CodingKey {
        
        case date = "dt"
        case main
        case weather = "weather"
        case dateText = "dt_txt"
    }
    
}
