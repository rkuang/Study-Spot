//
//  ReviewsDataSource+Delegate.swift
//  Study Spot
//
//  Created by Ricky Kuang on 12/5/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit

private let reviewsReuseId = "reviewsCell"

class ReviewsCollectionDelegateAndDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var reviews = [Review]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewsReuseId, for: indexPath) as! ReviewsCell
        let review = reviews[indexPath.row]
        cell.populate(review: review)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let height = calculateHeightForCell(text: reviews[indexPath.row].text, width: collectionView.frame.width)
        return CGSize(width: collectionView.frame.width-48, height: 160)
    }
    
    func calculateHeightForCell(text:String, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 4
        label.font = UIFont(name: "Futura", size: 17)
        label.text = text
        label.sizeToFit()
        
        let dimens: [String: CGFloat] = ["avatar": 40, "stars": 20, "padding": 24]
        
        return label.frame.height + dimens["avatar"]! + dimens["stars"]! + dimens["padding"]!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
