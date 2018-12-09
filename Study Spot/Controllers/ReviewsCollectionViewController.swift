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
    
//    let dataSourceAndDelegate = ReviewsCollectionDelegateAndDataSource(docRef: <#T##DocumentReference#>)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        collectionView.delegate = dataSourceAndDelegate
//        collectionView.dataSource = dataSourceAndDelegate
    }
}
