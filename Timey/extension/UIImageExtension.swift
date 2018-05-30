//
//  UIImageExtension.swift
//  Timey
//
//  Created by Jean Pierre on 1/25/18.
//  Copyright © 2018 Jean Pierre Figaredo. All rights reserved.
//

import Foundation
import UIKit
import ImageIO
import MobileCoreServices

extension UIImage {
    
    static func rotateImageUp(image: UIImage) -> UIImage {
            if image.imageOrientation == UIImageOrientation.up {
                return image
            }
            UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
            image.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: image.size))
            let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return normalizedImage
    }
}
