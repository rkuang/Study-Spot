//
//  OfferingsCell.swift
//  Study Spot
//
//  Created by Ricky Kuang on 11/29/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit

class OfferingsCell : UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 17)
        label.textColor = UIColor(white: 0.45, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[image(25@999)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["image": imageView]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["label": label]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[image(25)]-12-[label]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["image": imageView, "label": label]))
        
    }
    
    func populate(offering: (String, String)) {
        imageView.image = UIImage(named: offering.0)
        label.text = offering.1
    }
    
}
