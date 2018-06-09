//
//  APIsUrlsConstant.swift
//  Weather
//
//  Created by Marian on 6/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation

struct Constants {
    static let apiKey = "b6f346ac40e0c5c71e73d978bd6c5125"

    static let baseURL = "http://api.openweathermap.org/data/2.5/"
    static let iconsBaseURL = "http://openweathermap.org/img/w/"
    
    struct WeatherAPIs {
        static let cityWeather = "forecast?q="
        static let findCity = "find?q="

    }
}
