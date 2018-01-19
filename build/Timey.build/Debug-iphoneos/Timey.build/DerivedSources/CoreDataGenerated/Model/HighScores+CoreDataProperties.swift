//
//  HighScores+CoreDataProperties.swift
//  
//
//  Created by Jean Pierre on 1/18/18.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension HighScores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HighScores> {
        return NSFetchRequest<HighScores>(entityName: "HighScores")
    }

    @NSManaged public var date: Date?
    @NSManaged public var taps: Int32
    @NSManaged public var time: String?
    @NSManaged public var title: String?

}
