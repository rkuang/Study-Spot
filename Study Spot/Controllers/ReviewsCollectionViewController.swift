//
//  ReviewsCollectionView.swift
//  Study Spot
//
//  Created by Ricky Kuang on 12/5/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit
import FirebaseFirestore

private let reuseId = "reviewsCell"

class ReviewsCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataSourceAndDelegate = ReviewsDelegateAndDataSource()
    var docRef: DocumentReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uiBusy = UIActivityIndicatorView(style: .gray)
        uiBusy.startAnimating()
        collectionView.backgroundView = uiBusy
        
        collectionView.delegate = dataSourceAndDelegate
        collectionView.dataSource = dataSourceAndDelegate
        dataSourceAndDelegate.retrieveReviews(docRef: self.docRef) {
            self.collectionView.reloadData()
            (self.collectionView.backgroundView as! UIActivityIndicatorView).stopAnimating()
        }
    }
}
