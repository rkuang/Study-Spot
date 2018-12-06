//
//  DetailViewController.swift
//  Study Spot
//
//  Created by Ricky Kuang on 11/27/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit
import DGCollectionViewLeftAlignFlowLayout
import Cosmos
import FirebaseFirestore


private let offeringsCell = "offeringsCell"
private let reviewsCell = "reviewsCell"

private let offerings = [
    "free-wifi": ("wifi-solid", "Free Wifi"),
    "power-outlets": ("plug-solid", "Power Outlets"),
    "big-workspace": ("pencil-alt-solid", "Big Workspace"),
    "well-lit": ("lightbulb-solid", "Well Lit")
]

class StudySpotDetailViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: UIViewController
    
    var spot: StudySpot!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
        setupViews()
        getReviews()
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var noiseSlider: CustomSlider!
    @IBOutlet weak var activitySlider: CustomSlider!
    @IBOutlet weak var comfortSlider: CustomSlider!
    
    func setupViews() {
        name.text = spot.name
        rating.rating = spot.rating
        
        noiseSlider.value = Float(spot.environment["noise"] ?? 0)
        activitySlider.value = Float(spot.environment["activity"] ?? 0)
        comfortSlider.value = Float(spot.environment["comfort"] ?? 0)
    }
    
    @IBOutlet weak var offeringsCollectionView: UICollectionView!
    @IBOutlet weak var offeringsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var flowlayout: DGCollectionViewLeftAlignFlowLayout!
    @IBOutlet weak var reviewsCollectionView: UICollectionView!
    @IBOutlet weak var reviewsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerImage: UIImageView!
    
    let reviewsDataSourceAndDelegate = ReviewsCollectionDelegateAndDataSource()
    let offeringsDataSourceAndDelegate = OfferingsCollectionDelegateAndDataSource()
    
    func setupCollectionViews() {
        offeringsCollectionView.delegate = offeringsDataSourceAndDelegate
        offeringsCollectionView.dataSource = offeringsDataSourceAndDelegate
        flowlayout.itemSize = CGSize(width: 100, height: 25)
        flowlayout.estimatedItemSize = CGSize(width: 100, height: 25)
        
        reviewsCollectionView.delegate = reviewsDataSourceAndDelegate
        reviewsCollectionView.dataSource = reviewsDataSourceAndDelegate
        
        offeringsCollectionViewHeight.constant = offeringsCollectionView.collectionViewLayout.collectionViewContentSize.height
        reviewsCollectionViewHeight.constant = reviewsCollectionView.collectionViewLayout.collectionViewContentSize.height
        view.setNeedsLayout()
    }
    
    var docRef: DocumentReference!
    var reviews = [Review]()
    
    func getReviews() {
        let query = docRef.collection("reviews").limit(to: 3)
        query.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if let model = Review(dictionary: document.data()) {
                        self.reviews.append(model)
                    } else {
                        fatalError("Failed to instantiate StudySpot")
                    }
                }
            }
            self.reloadData(collectionView: self.reviewsCollectionView, height: self.reviewsCollectionViewHeight)
        }
    }
    
    func reloadData(collectionView: UICollectionView, height: NSLayoutConstraint) {
        collectionView.reloadData()
        height.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
        self.view.setNeedsLayout()
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y =  scrollView.contentOffset.y
        if y < 0 {
            headerImage.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: 240 - y)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "seeAllReviewsSegue" {
//            let vc = segue.destination as! ReviewsViewController
//        }
//    }
}