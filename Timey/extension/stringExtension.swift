//
//  stringExtension.swift
//  Timey
//
//  Created by Jean Pierre on 1/18/18.
//  Copyright © 2018 Jean Pierre Figaredo. All rights reserved.
//

import Foundation

extension String {
    /**
     Generates a unique string that can be used as a filename for storing data objects that need to ensure they have a unique filename. It is guranteed to be unique.
     
     - parameter prefix: The prefix of the filename that will be added to every generated string.
     - returns: A string that will consists of a prefix (if available) and a generated unique string.
     */
    static func uniqueFilename(withPrefix prefix: String? = nil) -> String {
        let uniqueString = ProcessInfo.processInfo.globallyUniqueString
        if prefix != nil {
            return "\(prefix!)-\(uniqueString)"
        }
        return uniqueString
    }
}
