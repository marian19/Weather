//
//  LMMain+CoreDataClass.swift
//  
//
//  Created by Marian on 6/8/18.
//
//

import Foundation
import CoreData

@objc(LMMain)
public class LMMain: NSManagedObject {

    public class func saveMain(temp: Double?, tempMin: Double?, tempMax: Double?) -> (LMMain?){
        let managedObjectContext = CoreDataManager.sharedInstance.managedObjectContext
        
           let main = NSEntityDescription.insertNewObject(forEntityName: "LMMain", into: managedObjectContext) as? LMMain
            
        main?.temp = temp!
        main?.tempMin = tempMin!
        main?.tempMax = tempMax!
            
            do {
                try managedObjectContext.save()
                return(main)
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        
    }
    
}
