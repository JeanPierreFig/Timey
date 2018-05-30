//
//  TinyCollectionViewCell.swift
//  Timey
//
//  Created by Jean Pierre on 5/27/18.
//  Copyright © 2018 Jean Pierre Figaredo. All rights reserved.
//

import UIKit

class TinyCollectionViewCell: UICollectionViewCell {
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var containerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setupView() {
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.clipsToBounds = true
    }
    
    public func resetCell() {
        contentView.layer.cornerRadius = 0
        contentView.layer.borderWidth = 0
    }
    
    var photo: UIImage? {
        didSet {
            imageView.image = photo
        }
    }
    
    var imgView: UIImageView{
        return self.imageView
    }
}
