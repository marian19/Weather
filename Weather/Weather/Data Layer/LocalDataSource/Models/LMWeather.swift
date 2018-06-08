//
//  LMWeather+CoreDataClass.swift
//  
//
//  Created by Marian on 6/8/18.
//
//

import Foundation
import CoreData

@objc(LMWeather)
public class LMWeather: NSManagedObject {
    
    public class func saveWeather(desc: String?, icon: String?) -> (LMWeather?){
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        
        let weather = NSEntityDescription.insertNewObject(forEntityName: "LMWeather", into: managedObjectContext) as? LMWeather
        
        weather?.desc = desc
        weather?.icon = icon
        
        do {
            try managedObjectContext.save()
            return(weather)
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
    }
}
