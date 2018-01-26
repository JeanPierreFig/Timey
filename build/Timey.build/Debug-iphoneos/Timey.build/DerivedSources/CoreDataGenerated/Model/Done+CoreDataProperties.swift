//
//  Done+CoreDataProperties.swift
//  
//
//  Created by Jean Pierre on 1/25/18.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Done {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Done> {
        return NSFetchRequest<Done>(entityName: "Done")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var title: String?
    @NSManaged public var videoPath: String?

}
