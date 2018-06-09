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

    public class func saveCityInfo(date: Int?, desc: String?, icon: String?, temp: Double?) -> (LMCityInfo?){
        
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        
        let cityInfo = NSEntityDescription.insertNewObject(forEntityName: "LMCityInfo", into: managedObjectContext) as? LMCityInfo
        
        cityInfo?.date = Int64(date!)
        cityInfo?.desc = desc!
        cityInfo?.icon = icon!
        cityInfo?.temp = temp!
        
        do {
            try managedObjectContext.save()
            return(cityInfo)
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
    }
}
