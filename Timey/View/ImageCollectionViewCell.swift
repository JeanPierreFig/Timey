//
//  ImageCollectionViewCell.swift
//  Timey
//
//  Created by Jean Pierre on 1/20/18.
//  Copyright © 2018 Jean Pierre Figaredo. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 6
        containerView.layer.masksToBounds = true
        
        //Add gradint, this way the lable can be seen.
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor,UIColor(red: 0, green: 0, blue: 0, alpha: 0.0).cgColor]
        gradientLayer.frame = frame
        imageView.layer.addSublayer(gradientLayer)
    }
    
    var photo: UIImage? {
        didSet {
            imageView.image = photo
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var imgView: UIImageView{
        return self.imageView
    }
}
