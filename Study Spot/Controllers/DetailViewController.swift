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

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    @IBOutlet weak var offeringsCollectionView: UICollectionView!
    @IBOutlet weak var offeringsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var flowlayout: DGCollectionViewLeftAlignFlowLayout!
    @IBOutlet weak var reviewsCollectionView: UICollectionView!
    @IBOutlet weak var reviewsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerImage: UIImageView!
    
    let offeringsCell = "offeringsCell"
    let reviewsCell = "reviewsCell"

    let offerings = [
        Offering(image: "wifi-solid", name: "Free WiFi"),
        Offering(image: "plug-solid", name: "Power Outlets"),
        Offering(image: "pencil-alt-solid", name: "Big Workspace"),
        Offering(image: "lightbulb-solid", name: "Well Lit")
    ]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.offeringsCollectionView:
            return spot.offerings.count
        case self.reviewsCollectionView:
            return 3
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.offeringsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: offeringsCell, for: indexPath) as! OfferingsCell
            let offering = offerings[indexPath.row]
            cell.imageView.image = UIImage(named: offering.image)
            cell.label.text = offering.name
            return cell
        case self.reviewsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewsCell, for: indexPath) as! ReviewsCell
            return cell
        default:
            fatalError("bad cell")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.reviewsCollectionView {
            let height = calculateHeightForCell(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer ornare quam sed nibh fermentum gravida a vel turpis.", width: collectionView.frame.width)
            return CGSize(width: collectionView.frame.width, height: height)
        }
        return (collectionViewLayout as! UICollectionViewFlowLayout).itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y =  scrollView.contentOffset.y
        if y < 0 {
            headerImage.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: 240 - y)
        }
    }
    
    var spot: StudySpot!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
        setupViews()
        print(spot)
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
    
    func calculateHeightForCell(text:String, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 4
        label.font = UIFont(name: "Futura", size: 17)
        label.text = text
        label.sizeToFit()
        
        let dimens: [String: CGFloat] = ["avatar": 40, "stars": 20, "padding": 24]
        
        return label.frame.height + dimens["avatar"]! + dimens["stars"]! + dimens["padding"]!
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
