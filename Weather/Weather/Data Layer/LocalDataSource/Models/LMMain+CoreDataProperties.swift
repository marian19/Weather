//
//  LMMain+CoreDataProperties.swift
//  
//
//  Created by Marian on 6/8/18.
//
//

import Foundation
import CoreData


extension LMMain {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LMMain> {
        return NSFetchRequest<LMMain>(entityName: "LMMain")
    }

    @NSManaged public var temp: Double
    @NSManaged public var tempMin: Double
    @NSManaged public var tempMax: Double

}
