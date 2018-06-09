//
//  WeatherRepository.swift
//  Weather
//
//  Created by Marian on 6/8/18.
//  Copyright © 2018 Marian. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherRepository: NSObject, CLLocationManagerDelegate{
    
    // MARK: - Shared Instance
    static let sharedInstance =  WeatherRepository()
    var locationManager: CLLocationManager = CLLocationManager()
    var didFindLocation: Bool = false
    var completionHandler: (([LMCityWeather]?, String?)->Void)?
    private override init() {
        super.init()
        locationManager.delegate = self
        
    }
    
    func findCity(cityName: String,completion: @escaping(_ response: FindCity?, _ errorMessage: String?) -> Void){
        
        if Connectivity.isConnectedToInternet{
            WeatherRemoteDataSource().findCity(cityName: cityName) { (result, error) in
                if error == nil{
                    completion(result, nil)
                }else{
                    completion(nil, error?.localizedDescription)
                    
                }
            }
        }else{
            completion(nil, "check_connection".localized())
        }
    }
    
    func getAllCities(completion:@escaping(_ response: [LMCityWeather]?, _ error: String?) -> Void){
        self.completionHandler = completion
        do {
            let results = try CoreDataManager.sharedInstance.managedObjectContext.fetch(LMCityWeather.fetchRequest())
            
            let  cities = results as! [LMCityWeather]
            
            if cities.count > 0{
                if Connectivity.isConnectedToInternet{
                    var newCitiesData = [LMCityWeather]()
                    let names = getCitiesName(cityList: cities)
                    for name in names{
                        WeatherRepository.sharedInstance.getCityWeather(cityName: name) { (result, error) in
                            if error == nil && results != nil{
                                newCitiesData.append(result!)
                                if newCitiesData.count == names.count{
                                    completion( newCitiesData, error)
                                }
                            }else{
                                completion( nil, error)
                                
                            }
                        }
                    }
                    
                }else{
                    return completion(cities, nil)
                }
            }else{
                
                locationManager.distanceFilter = 100.0
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
                
                if CLLocationManager.locationServicesEnabled() {
                    switch CLLocationManager.authorizationStatus() {
                    case .notDetermined:
                        locationManager.requestAlwaysAuthorization()
                    case .restricted, .denied:
                        print("No access")
                        getDefaultCity()
                    case .authorizedAlways, .authorizedWhenInUse:
                        print("Access")
                    }
                } else {
                    print("Location services are not enabled")
                }
                
            }
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        
    }
    
    private func getDefaultCity(){
        var cities = [LMCityWeather]()
        
        WeatherRepository.sharedInstance.getCityWeather(cityName: "London,UK") { (cityWeather, error) in
            if error == nil {
                if let _ = cityWeather{
                    cities.append(cityWeather!)
                }
                self.completionHandler!(cities, nil)
            }else{
                self.completionHandler!(nil, error)
                
            }
        }
    }
    private func getCitiesName(cityList: [LMCityWeather]) -> [String] {
        return cityList.map({"\($0.name!),\($0.country!)"})
        
    }
    
    func getCityWeather(cityName: String,completion: @escaping(_ response: LMCityWeather?, _ error: String?) -> Void){
        if Connectivity.isConnectedToInternet{
            WeatherRemoteDataSource().getCityWeather(cityName: cityName) { (result, error) in
                
                if error == nil{
                    let cityWeather = self.saveCityWithData(id: result?.city?.id, name: result?.city?.name, country: result?.city?.country, tempInfo: result?.list)
                    
                    
                    completion(cityWeather, nil)
                }else{
                    completion(nil, error?.localizedDescription)
                    
                }
            }
        }else{
            
        }
    }
    
    func saveCityToCoreData(city: City) -> String{
        do {
            
            let results = try CoreDataManager.sharedInstance.managedObjectContext.fetch(LMCityWeather.fetchRequest())
            
            let  cities = results as! [LMCityWeather]
            
            if cities.count == 5{
                
                return "max_cities".localized()
            }else{
                var tempInfo = [List]()
                
                let listItem = List(date: city.dt, main: city.main, weather: city.weather, dateText: nil)
                tempInfo.append(listItem)
                
                self.saveCityWithData(id: city.id, name: city.name, country: city.sys?.country, tempInfo: tempInfo)
                
                return "city_added_to_favorit".localized()
            }
            
            
        }catch let error as NSError {
            print("Could not fetch \(error)")
        }
        
        return "somethingWrong".localized()
    }
    
    
    private func saveCityWithData(id: Int?, name: String?, country: String?, tempInfo:[List]?) -> LMCityWeather?{
        
        let cityWeather = LMCityWeather.saveCityWeather(id: id, name: name, country: country)
        
        
        for info in tempInfo!{
            
            let infoWeather: Weather = info.weather![0]
            let cityInfo = LMCityInfo.saveCityInfo(date: info.date, desc:infoWeather.description,icon:infoWeather.icon, temp:info.main?.temp)
            cityWeather?.addToList(cityInfo!)
        }
        CoreDataManager.sharedInstance.saveContext()
        return cityWeather
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            self.locationManager.stopUpdatingLocation()
            self.locationManager.delegate = nil
            manager.stopUpdatingLocation()
            manager.delegate = nil
            
            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if (placemarks?.count)! > 0 {
                let pm = placemarks?[0]
                self.displayLocationInfo(pm)
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func displayLocationInfo(_ placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let country = (containsPlacemark.isoCountryCode != nil) ? containsPlacemark.isoCountryCode : ""
            print("\(country!) \(locality!)")
            if didFindLocation == false{
                WeatherRepository.sharedInstance.getCityWeather(cityName: "\(locality!),\(country!)") { (cityWeather, error) in
                    if error == nil {
                        var cities = [LMCityWeather]()
                        if let _ = cityWeather{
                            cities.append(cityWeather!)
                        }
                        self.completionHandler!(cities, nil)
                    }else{
                        self.completionHandler!(nil, error)
                        
                    }
                }
            }
            didFindLocation = true
            
            
        }
        
    }
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted{
            print("dennnnnied")
            getDefaultCity()
        }
    }
    
    
}
