//
//  LMWeather+CoreDataProperties.swift
//  
//
//  Created by Marian on 6/8/18.
//
//

import Foundation
import CoreData


extension LMWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LMWeather> {
        return NSFetchRequest<LMWeather>(entityName: "LMWeather")
    }

    @NSManaged public var desc: String?
    @NSManaged public var icon: String?

}
