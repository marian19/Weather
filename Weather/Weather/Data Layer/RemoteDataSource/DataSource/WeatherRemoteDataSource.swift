//
//  WeatherDataScource.swift
//  Weather
//
//  Created by Marian on 6/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation


struct WeatherRemoteDataSource {
    
    let httpClient = AlamofireClient.sharedInstance
    
    func findCity(cityName: String,completion: @escaping(_ response: FindCity?, _ error: Error?) -> Void) {
        
        httpClient.getRequest(path: Constants.WeatherAPIs.findCity + cityName, parameters: nil) { (responseData , error) in
            if error == nil{
                let decoder = JSONDecoder()
                do {
                    let decoderData = try decoder.decode(FindCity.self, from: responseData!)
                    completion(decoderData, nil)
                } catch {
                    print(error)
                }
                
            }else{
                completion(nil,error)
                
            }
        }
    }
    
    func getCityWeather(cityName: String,completion: @escaping(_ response: CityWeather?, _ error: Error?) -> Void ) {
        
        httpClient.getRequest(path: Constants.WeatherAPIs.cityWeather + cityName, parameters: nil) { (responseData , error) in
            if error == nil{
                let decoder = JSONDecoder()
                do {
                    let decoderData = try decoder.decode(CityWeather.self, from: responseData!)
                    completion(decoderData,nil)
                } catch {
                    print(error)
                }
                
            }else{
                completion(nil,error)
            }
        }
    }
}
