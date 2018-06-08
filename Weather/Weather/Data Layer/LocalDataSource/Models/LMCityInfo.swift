//
//  LMList+CoreDataClass.swift
//  
//
//  Created by Marian on 6/8/18.
//
//

import Foundation
import CoreData

@objc(LMCityInfo)
public class LMCityInfo: NSManagedObject {

    public class func saveCityInfo(date: String?, main: LMMain?, weather: LMWeather?) -> (LMCityInfo?){
        
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        
        let cityInfo = NSEntityDescription.insertNewObject(forEntityName: "LMCityInfo", into: managedObjectContext) as? LMCityInfo
        
        cityInfo?.date = date
        cityInfo?.main = main
        cityInfo?.weather = weather
        
        do {
            try managedObjectContext.save()
            return(cityInfo)
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
    }
}
