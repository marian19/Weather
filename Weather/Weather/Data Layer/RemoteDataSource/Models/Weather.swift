//
//  Weather.swift
//  Weather
//
//  Created by Marian on 6/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation

struct Weather : Codable {
    
    let description : String?
    let icon : String?
    
    enum CodingKeys: String, CodingKey {
        
        case description = "description"
        case icon = "icon"
    }
    
}
