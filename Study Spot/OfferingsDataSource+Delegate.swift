//
//  ReviewsCollection.swift
//  Study Spot
//
//  Created by Ricky Kuang on 12/5/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit

private let offeringsReuseId = "offeringsCell"

private let offerings_map = [
    "free-wifi": ("wifi-solid", "Free Wifi"),
    "power-outlets": ("plug-solid", "Power Outlets"),
    "big-workspace": ("pencil-alt-solid", "Big Workspace"),
    "well-lit": ("lightbulb-solid", "Well Lit")
]

class OfferingsCollectionDelegateAndDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var offerings: [String]!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return offerings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: offeringsReuseId, for: indexPath) as! OfferingsCell
        let offering = offerings[indexPath.row]
        cell.populate(offering: offerings_map[offering]!)
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
}
