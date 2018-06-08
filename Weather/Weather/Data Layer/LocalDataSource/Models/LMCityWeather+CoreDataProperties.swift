//
//  LMCityWeather+CoreDataProperties.swift
//  
//
//  Created by Marian on 6/8/18.
//
//

import Foundation
import CoreData


extension LMCityWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LMCityWeather> {
        return NSFetchRequest<LMCityWeather>(entityName: "LMCityWeather")
    }

    @NSManaged public var cityID: Int64
    @NSManaged public var name: String?
    @NSManaged public var country: String?
    @NSManaged public var list: NSSet?

}

// MARK: Generated accessors for list
extension LMCityWeather {

    @objc(addListObject:)
    @NSManaged public func addToList(_ value: LMCityInfo)

    @objc(removeListObject:)
    @NSManaged public func removeFromList(_ value: LMCityInfo)

    @objc(addList:)
    @NSManaged public func addToList(_ values: NSSet)

    @objc(removeList:)
    @NSManaged public func removeFromList(_ values: NSSet)

}
