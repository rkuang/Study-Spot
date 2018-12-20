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
        imageView.image = UIImage(named: "placeholder-image")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 17)
        label.textColor = UIColor(white: 0.45, alpha: 1)
        label.text = "John Doe"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timestamp: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 15)
        label.textColor = UIColor(white: 0.45, alpha: 1)
        label.text = "12/19/2018"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rating: CosmosView = {
        let cosmos = CosmosView()
        cosmos.settings.updateOnTouch = false
        cosmos.settings.emptyColor = .clear
        cosmos.settings.emptyBorderColor = .black
        cosmos.settings.filledColor = .black
        cosmos.settings.filledBorderColor = .black
        cosmos.settings.emptyBorderWidth = 1
        cosmos.translatesAutoresizingMaskIntoConstraints = false
        return cosmos
    }()
    
    let text: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura", size: 17)
        label.textColor = UIColor(white: 0.45, alpha: 1)
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer ornare quam sed nibh fermentum gravida a vel turpis."
        label.numberOfLines = 4
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        contentView.addSubview(avatar)
        contentView.addSubview(name)
        contentView.addSubview(timestamp)
        contentView.addSubview(rating)
        contentView.addSubview(text)
        
        let viewsDict = ["avatar": avatar, "name": name, "timestamp": timestamp, "rating": rating, "text": text]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[avatar(40)]-[rating]-[text]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[name]-[rating(20)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[timestamp]-[rating]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[avatar(40)]-16-[name]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[timestamp]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[rating]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[text]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDict))
        
    }
    
    func populate(review: Review) {
        rating.rating = review.rating
        text.text = review.text
        
        let date: Date = review.timestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        timestamp.text = dateFormatter.string(from: date)
    }
}
