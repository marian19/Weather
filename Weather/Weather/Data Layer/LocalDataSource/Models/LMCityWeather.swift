//
//  LMCityWeather+CoreDataClass.swift
//  
//
//  Created by Marian on 6/8/18.
//
//

import Foundation
import CoreData

@objc(LMCityWeather)
public class LMCityWeather: NSManagedObject {
    
    public class func saveCityWeather(id: Int?, name: String?, country: String?) -> (LMCityWeather?){
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        
        var cityWeather = LMCityWeather.getCityWeatherWith(id: id)
        
        if (cityWeather != nil)  {
            return(cityWeather)
        }else{
            
            cityWeather = NSEntityDescription.insertNewObject(forEntityName: "LMCityWeather", into: managedObjectContext) as? LMCityWeather
            
            cityWeather?.cityID = Int64(id!)
            cityWeather?.name = name!
            cityWeather?.country = country!
            
            do {
                try managedObjectContext.save()
                return(cityWeather)
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
    public class func getCityWeatherWith(id:Int?) -> LMCityWeather? {
        
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        var cityWeather: LMCityWeather?
        do {
            let fetchRequest : NSFetchRequest<LMCityWeather> = LMCityWeather.fetchRequest()
            
            fetchRequest.predicate = NSPredicate(format: "cityID = %i", id!)
            
            let fetchedResults = try managedObjectContext.fetch(fetchRequest)
            if fetchedResults.first != nil {
                cityWeather = fetchedResults.first
            }
        }
        catch {
            print ("fetch task failed", error)
        }
        return cityWeather
    }
}
