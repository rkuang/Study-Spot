//
//  ReviewsDataSource+Delegate.swift
//  Study Spot
//
//  Created by Ricky Kuang on 12/5/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit
import FirebaseFirestore

private let reviewsReuseId = "reviewsCell"

class ReviewsDelegateAndDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var reviews: [Review]
    var db: Firestore
    var limit: Int
    var docRef: DocumentReference!
    
    override init() {
        self.reviews = [Review]()
        self.db = Firestore.firestore()
        self.limit = 25
    }
    
    init(limit: Int) {
        self.reviews = [Review]()
        self.db = Firestore.firestore()
        self.limit = limit
    }
    
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
        let width = collectionView.frame.width-32
        let height = calculateHeightForCell(text: reviews[indexPath.row].text, width: width)
        return CGSize(width: collectionView.frame.width-32, height: height)
    }
    
    func calculateHeightForCell(text:String, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 4
        label.font = UIFont(name: "Futura", size: 17)
        label.text = text
        label.sizeToFit()
        
        let dimens: [String: CGFloat] = ["avatar": 40, "stars": 20, "padding": 16]
        
        return label.frame.height + dimens["avatar"]! + dimens["stars"]! + dimens["padding"]!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    // MARK: - Firestore
    
    func retrieveReviews(docRef: DocumentReference, _ callback: @escaping () -> Void) {
        let reviewsCollection = self.db.reviews(docRef: docRef).order(by: "timestamp", descending: true).limit(to: self.limit)
        reviewsCollection.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if let model = Review(dictionary: document.data()) {
                        self.reviews.append(model)
                    } else {
                        fatalError("Could not deserialize Review")
                    }
                }
                callback()
            }
        }
    }
}
