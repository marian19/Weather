//
//  WeatherRepository.swift
//  Weather
//
//  Created by Marian on 6/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation

struct WeatherRepository{
    
    // MARK: - Shared Instance
    static let sharedInstance =  WeatherRepository()
    
    private init() {
    }
    
    func findCity(cityName: String,completion: @escaping(_ response: FindCity) -> Void){
        
        if Connectivity.isConnectedToInternet{
            
        }else{
         
        }
    }
    
    func getCityWeather(cityName: String,completion: @escaping(_ response: LMCityWeather?) -> Void){
        if Connectivity.isConnectedToInternet{
            WeatherRemoteDataSource().getCityWeather(cityName: cityName) { (rCityWeather) in
                
                CoreDataManager.sharedInstance.clearCoreDataStore()
                
                let cityWeather = LMCityWeather.saveCityWeather(id: rCityWeather.city?.id, name: rCityWeather.city?.name, country: rCityWeather.city?.country)
                
                
                for info in rCityWeather.list!{
                    let main = LMMain.saveMain(temp: info.main?.temp, tempMin: info.main?.tempMin, tempMax: info.main?.tempMax)
                    let infoWeather: Weather = info.weather![0]
                    let weather = LMWeather.saveWeather(desc: infoWeather.description, icon: infoWeather.icon)
                    let cityInfo = LMCityInfo.saveCityInfo(date: info.dateText, main: main, weather: weather)
                    cityWeather?.addToList(cityInfo!)
                }
                
                completion(cityWeather)
            }
        }else{
            
        }
    }
}
