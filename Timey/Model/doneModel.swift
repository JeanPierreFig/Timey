//
//  doneModel.swift
//  Timey
//
//  Created by Jean Pierre on 1/25/18.
//  Copyright © 2018 Jean Pierre Figaredo. All rights reserved.
//

import Foundation

import Foundation

class DoneModel {
    var title:String
    var createdAt:Date
    var videoURL: URL!
    
    init(title:String,createdAt:Date, videoName:String) {
        self.title = title
        self.createdAt = createdAt
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(videoName)
            print(fileURL)
            self.videoURL = fileURL
        }
    }
    
}
