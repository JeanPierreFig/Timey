//
//  Timelapse+CoreDataProperties.swift
//  
//
//  Created by Jean Pierre on 1/22/18.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Timelapse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Timelapse> {
        return NSFetchRequest<Timelapse>(entityName: "Timelapse")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var imagesPath: NSObject?
    @NSManaged public var title: String?

}
