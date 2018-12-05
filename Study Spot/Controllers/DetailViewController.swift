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

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.offeringsCollectionView:
            return spot.offerings.count
        case self.reviewsCollectionView:
            return reviews.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.offeringsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: offeringsCell, for: indexPath) as! OfferingsCell
            let offering = spot.offerings[indexPath.row]
            cell.populate(offering: offerings[offering]!)
            return cell
        case self.reviewsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewsCell, for: indexPath) as! ReviewsCell
            let review = reviews[indexPath.row]
            cell.populate(review: review)
            return cell
        default:
            fatalError("bad cell")
        }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.reviewsCollectionView {
            let height = calculateHeightForCell(text: reviews[indexPath.row].text, width: collectionView.frame.width)
            return CGSize(width: collectionView.frame.width, height: height)
        }
        return (collectionViewLayout as! UICollectionViewFlowLayout).itemSize
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y =  scrollView.contentOffset.y
        if y < 0 {
            headerImage.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: 240 - y)
        }
    }
    
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
    
    func setupCollectionViews() {
        offeringsCollectionView.delegate = self
        offeringsCollectionView.dataSource = self
        flowlayout.itemSize = CGSize(width: 100, height: 25)
        flowlayout.estimatedItemSize = CGSize(width: 100, height: 25)
        
        reviewsCollectionView.delegate = self
        reviewsCollectionView.dataSource = self
        
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
}
