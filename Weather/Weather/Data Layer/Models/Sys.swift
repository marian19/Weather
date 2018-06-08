//
//  Sys.swift
//  Weather
//
//  Created by Marian on 6/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation

struct Sys : Codable {
    
    let country : String?
    
    enum CodingKeys: String, CodingKey {
        
        case country = "country"
    }
    
}
