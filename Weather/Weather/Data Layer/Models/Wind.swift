//
//  Wind.swift
//  Weather
//
//  Created by Marian on 6/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation

struct Wind : Codable {
    
    let speed : Double?
    let deg : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case speed = "speed"
        case deg = "deg"
    }
}
