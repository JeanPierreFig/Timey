//
//  inprogress.swift
//  Timey
//
//  Created by Jean Pierre on 1/18/18.
//  Copyright © 2018 Jean Pierre Figaredo. All rights reserved.
//

import Foundation
import UIKit

class inprogress {
    var title:String
    var createdAt:Date
    var images:[UIImage]!
   
    
    init(title:String,createdAt:Date, imagesName:[String]) {
        self.title = title
        self.createdAt = createdAt
        self.images = [UIImage]()
       
        //Get images from the FileManger and
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            for name in imagesName{
                let fileURL = dir.appendingPathComponent(name)
                do {
                    let imageData = try Data(contentsOf: fileURL)
                    print(fileURL)
                    self.images.append(UIImage(data: imageData)!)
                }
                catch{
                    print("error: loading image data.")
                }
               
            }
        }
    }
}
