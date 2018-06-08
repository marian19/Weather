//
//  FindCity.swift
//  Weather
//
//  Created by Marian on 6/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation

struct FindCity : Codable {
    
    let list : [City]?
    
    enum CodingKeys: String, CodingKey {
        
        case list = "list"
    }
    
}
