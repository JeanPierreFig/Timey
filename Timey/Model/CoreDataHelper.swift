//
//  CoreDataHelper.swift
//  Timey
//
//  Created by Jean Pierre on 5/27/18.
//  Copyright © 2018 Jean Pierre Figaredo. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHelper {
    
    /**
     Load the content stored in CoreData into an array of object
     - Parameter manageContext: NSManagedObjectContext
     - returns: [Content]
    */
    static func LoadData(manageContext: NSManagedObjectContext ) -> [Content] {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: CoreData_Entity_Name)
        var objects: [Content] = []
        do{
            for obj in try manageContext.fetch(fetchRequest){
                let title = obj.value(forKey: "title") as! String
                let imagePath = obj.value(forKey: "imagesPath") as! [String]
                let createdAt = obj.value(forKey: "createdAt") as! Date
                objects.append(Content(title: title, createdAt: createdAt, imagesName: imagePath))
            }
        }
        catch{
            print("error retrieving data.")
        }
        
        return objects
    }
    
}
