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
    var docRef: DocumentReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
        setupViews()
    }
    
    // TODO: deallocate listener
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var noiseSlider: CustomSlider!
    @IBOutlet weak var activitySlider: CustomSlider!
    @IBOutlet weak var comfortSlider: CustomSlider!
    @IBOutlet weak var scrollView: UIScrollView!
    var refreshControl: UIRefreshControl!
    
    func setupViews() {
        populateView(with: spot)
        
        noiseSlider.clearThumbImage()
        activitySlider.clearThumbImage()
        comfortSlider.clearThumbImage()
        
        scrollView.delegate = self
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshStudySpot), for: .valueChanged)
        scrollView.refreshControl = refreshControl
    }
    
    func populateView(with spot: StudySpot) {
        self.title = spot.name
        
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
    
    let reviewsDataSourceAndDelegate = ReviewsDelegateAndDataSource(limit: 3)
    let offeringsDataSourceAndDelegate = OfferingsCollectionDelegateAndDataSource()
    
    func setupCollectionViews() {
        setupOfferingsCollectionView()
        setupReviewsCollectionView()
    }
    
    func setupOfferingsCollectionView() {
        offeringsDataSourceAndDelegate.offerings = spot.offerings
        offeringsCollectionView.delegate = offeringsDataSourceAndDelegate
        offeringsCollectionView.dataSource = offeringsDataSourceAndDelegate
        flowlayout.itemSize = CGSize(width: 100, height: 25)
        flowlayout.estimatedItemSize = CGSize(width: 100, height: 25)
        offeringsCollectionViewHeight.constant = offeringsCollectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    func setupReviewsCollectionView() {
        reviewsCollectionView.delegate = reviewsDataSourceAndDelegate
        reviewsCollectionView.dataSource = reviewsDataSourceAndDelegate
        retrieveReviews()
        reviewsCollectionViewHeight.constant = reviewsCollectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    func retrieveReviews() {
        reviewsDataSourceAndDelegate.retrieveReviews(docRef: self.docRef) {
            self.reviewsCollectionView.reloadData()
            self.reviewsCollectionViewHeight.constant = self.reviewsCollectionView.collectionViewLayout.collectionViewContentSize.height
            self.view.setNeedsLayout()
        }
    }
    
    @objc func refreshStudySpot() {
        DispatchQueue.main.async {
            self.retrieveStudySpot()
            self.populateView(with: self.spot)
            self.retrieveReviews()
            self.refreshControl.endRefreshing()
        }
    }
    
    func retrieveStudySpot() {
        docRef.getDocument { (snapshot, err) in
            if let err = err {
                print("Error: \(err)")
            } else {
                if let model = StudySpot(dictionary: snapshot!.data()!) {
                    print(model)
                    self.spot = model
                } else {
                    fatalError("Failed to create StudySpot")
                }
            }
        }
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y =  scrollView.contentOffset.y
        if y < 0 {
            headerImage.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: 240 - y)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "seeAllReviewsSegue":
            let vc = segue.destination as! ReviewsCollectionViewController
            vc.docRef = self.docRef
        case "newReviewSegue":
            let vc = segue.destination as! NewReviewViewController
            vc.titleLabelText = self.spot.name
            vc.docRef = self.docRef
        default:
            break
        }
        if segue.identifier == "seeAllReviewsSegue" {
            let vc = segue.destination as! ReviewsCollectionViewController
            vc.docRef = self.docRef
        }
    }
    
    @IBAction func unwindToStudySpotDetailViewController(segue: UIStoryboardSegue) {
        print("unwinding")
        refreshStudySpot()
    }
}
