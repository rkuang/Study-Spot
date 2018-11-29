//
//  ReviewsCell.swift
//  Study Spot
//
//  Created by Ricky Kuang on 11/29/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit
import Cosmos

class ReviewsCell: UICollectionViewCell {
    let avatar: UIImageView = {
        let imageView = UIImageView()
//        imageView.backgroundColor = .black
        imageView.image = UIImage(named: "placeholder-image")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let name: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .black
        label.font = UIFont(name: "Futura", size: 17)
        label.textColor = UIColor(white: 0.30, alpha: 1)
        label.text = "John Doe"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rating: CosmosView = {
        let cosmos = CosmosView()
//        cosmos.backgroundColor = .yellow
        cosmos.settings.updateOnTouch = false
        cosmos.settings.emptyColor = .black
        cosmos.settings.emptyBorderColor = .black
        cosmos.settings.filledColor = .black
        cosmos.settings.filledBorderColor = .black
        cosmos.translatesAutoresizingMaskIntoConstraints = false
        return cosmos
    }()
    
    let text: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .black
        label.font = UIFont(name: "Futura", size: 17)
        label.textColor = UIColor(white: 0.45, alpha: 1)
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer ornare quam sed nibh fermentum gravida a vel turpis. Sed sit amet lacus quis lorem commodo feugiat vitae sit amet lacus. Nulla vel orci viverra, pellentesque turpis non, viverra tellus. Suspendisse potenti. Ut sit amet consequat mi. Vestibulum porta velit vel lobortis malesuada. In consectetur purus nisi, in bibendum quam ullamcorper nec. Phasellus accumsan, orci id consectetur ultrices, erat mi lobortis tortor, in dapibus erat dolor eget velit. Fusce sagittis magna lectus. Nullam interdum dolor turpis, ut consequat dolor aliquet nec."
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    override func awakeFromNib() {
        contentView.addSubview(avatar)
        contentView.addSubview(name)
        contentView.addSubview(rating)
        contentView.addSubview(text)
        
        let viewsDict = ["avatar": avatar, "name": name, "rating": rating, "text": text]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[avatar(40@999)]-[rating]-[text]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[name(==avatar)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[avatar(40@999)]-16-[name]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[text]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDict))
        
    }
}
