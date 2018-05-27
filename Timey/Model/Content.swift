//
//  inprogress.swift
//  Timey
//
//  Created by Jean Pierre on 1/18/18.
//  Copyright © 2018 Jean Pierre Figaredo. All rights reserved.
//

import Foundation
import UIKit

class Content {
    var title:String
    var createdAt:Date
    var imagesNames:[String]!
    var images:[UIImage]
    var firstImage:UIImage!
   
    init(title:String,createdAt:Date, imagesName:[String]) {
        self.title = title
        self.createdAt = createdAt
        self.imagesNames = imagesName
        self.images = [UIImage]()
       
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
                let name = imagesName[0]
                let fileURL = dir.appendingPathComponent(name)
                do {
                    let imageData = try Data(contentsOf: fileURL)
                    self.firstImage = UIImage(data: imageData)!
                }
                catch{
                    print("error: loading image data.")
                }
               
            }
        }

}
