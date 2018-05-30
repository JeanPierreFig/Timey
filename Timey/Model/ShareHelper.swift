//
//  ShareHelper.swift
//  Timey
//
//  Created by Jean Pierre on 5/28/18.
//  Copyright © 2018 Jean Pierre Figaredo. All rights reserved.
//

import Foundation
import Photos

class ShareHelper  {
    
   static func ToCameraRoll(fileURL:URL, completion: @escaping (String) -> ()) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: fileURL) }) { saved, error in
                if saved {
                    let fetchOptions = PHFetchOptions()
                    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                    let fetchResult = PHAsset.fetchAssets(with: .video, options: fetchOptions).firstObject
                    completion((fetchResult?.localIdentifier)!)
                }
        }
    }
    
}
