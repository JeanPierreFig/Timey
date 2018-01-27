//
//  InprogressTableViewCell.swift
//  Timey
//
//  Created by Jean Pierre on 1/25/18.
//  Copyright © 2018 Jean Pierre Figaredo. All rights reserved.
//

import UIKit


class InprogressTableViewCell: UITableViewCell {

    @IBOutlet var photoView: UIImageView!
    @IBOutlet var title:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        photoView.layer.cornerRadius = 6
        photoView.layer.borderWidth = 1
        photoView.layer.borderColor = UIColor.lightGray.cgColor
        photoView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
