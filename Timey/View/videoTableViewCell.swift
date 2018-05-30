//
//  videoTableViewCell.swift
//  Timey
//
//  Created by Jean Pierre on 1/25/18.
//  Copyright © 2018 Jean Pierre Figaredo. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class videoTableViewCell: UITableViewCell {
    @IBOutlet var videoTitleLabel: UILabel!
    @IBOutlet var playerView: PlayerView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
