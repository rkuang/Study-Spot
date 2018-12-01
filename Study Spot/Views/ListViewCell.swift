//
//  TableViewCell.swift
//  Study Spot
//
//  Created by Ricky Kuang on 11/19/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit
import Cosmos

class ListViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var num_reviews: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutMargins = UIEdgeInsets.zero
        self.preservesSuperviewLayoutMargins = false
    }
    
    func populate(spot: StudySpot) {
        self.name.text = spot.name
        self.rating.rating = spot.rating
        self.num_reviews.text = "\(spot.num_reviews) Reviews"
    }

}
