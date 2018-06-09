//
//  LMList+CoreDataProperties.swift
//  
//
//  Created by Marian on 6/8/18.
//
//

import Foundation
import CoreData


extension LMCityInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LMCityInfo> {
        return NSFetchRequest<LMCityInfo>(entityName: "LMCityInfo")
    }

    @NSManaged public var date: Int64
    @NSManaged public var temp: Double
    @NSManaged public var desc: String?
    @NSManaged public var icon: String?
}


