//
//  CoreDataHelper.swift
//  Timey
//
//  Created by Jean Pierre on 5/27/18.
//  Copyright © 2018 Jean Pierre Figaredo. All rights reserved.
//

import UIKit
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
                objects.append(Content(title: title, createdAt: createdAt, imagesPath: imagePath))
            }
        }
        catch{
            print("error retrieving data.")
        }
        
        return objects
    }
    
    /**
     update the image paths for all images
     - Parameter contentItem: Content
     - Parameter manageContext: NSManagedObjectContext
     */
    static func updateData(contentItem: Content, manageContext: NSManagedObjectContext, completion: () -> ()) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Timelapse")
        let predicate = NSPredicate(format: "title == '\(contentItem.createdAt)'")
        fetchRequest.predicate = predicate
        do {
            let test = try manageContext.fetch(fetchRequest)
            if test.count == 1 {
                let pathsForAllImage = contentItem.imagesPath
                let objectUpdate = test[0]
                objectUpdate.setValue(pathsForAllImage, forKey: "imagesPath")
                do {
                    try manageContext.save()
                    completion()
                }
                catch {
                    print(error)
                }
            }
        }
        catch {
            print(error)
        }
    }
    
    
    ///NOTE: Yes the Class is called CoreDataHelper but I'm also saving things to disk kill me. ;)
    
    /**
    Load images from Disk for selected object
     - Parameter imageNames: [Stirng]
     - returns: [UIImage]
     */
    static func RetrieveImagesFromDisk(imageNames:[String]) -> [UIImage] {
        var images = [UIImage]()
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            for name in imageNames{
                let fileURL = dir.appendingPathComponent(name)
                do {
                    let imageData = try Data(contentsOf: fileURL)
                    images.append(UIImage(data: imageData)!)
                }
                catch {
                    print("error: loading image data.")
                }
            }
        }
        return images
    }
    
    /**
     Save images to Disk from an array of UIImages.
     - Parameter imageNames: [Stirng]
     - returns: [UIImage]
     */
    static  func saveToDisk(images: [UIImage]) -> [String]{
        var imagesPath = [String]()
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            for image in images{
                let fileName = String.uniqueFilename()+".jpg"
                let fileURL = dir.appendingPathComponent(fileName)
                
                do {
                    try UIImageJPEGRepresentation(UIImage.rotateImageUp(image: image), 1)?.write(to: fileURL, options: .atomic)
                    imagesPath.append(fileName)
                }
                catch {
                    print("error: Saving the image to disk.")
                }
            }
        }
        
        return imagesPath
    }
}
