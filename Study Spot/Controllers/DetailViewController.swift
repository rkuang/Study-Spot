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

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let offeringsCell = "offeringsCell"
    let reviewsCell = "reviewsCell"

    let offerings = [
        Offering(image: "wifi-solid", name: "Free WiFi"),
        Offering(image: "plug-solid", name: "Power Outlets"),
        Offering(image: "pencil-alt-solid", name: "Big Workspace"),
        Offering(image: "lightbulb-solid", name: "Well Lit")
    ]
    
    @IBOutlet weak var offeringsCollectionView: UICollectionView!
    @IBOutlet weak var offeringsCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var flowlayout: DGCollectionViewLeftAlignFlowLayout!

    @IBOutlet weak var reviewsCollectionView: UICollectionView!
    @IBOutlet weak var reviewsCollectionViewHeight: NSLayoutConstraint!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.offeringsCollectionView:
            return offerings.count
        case self.reviewsCollectionView:
            return 2
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
            let height = calculateHeightForCell(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer ornare quam sed nibh fermentum gravida a vel turpis. Sed sit amet lacus quis lorem commodo feugiat vitae sit amet lacus. Nulla vel orci viverra, pellentesque turpis non, viverra tellus. Suspendisse potenti. Ut sit amet consequat mi. Vestibulum porta velit vel lobortis malesuada. In consectetur purus nisi, in bibendum quam ullamcorper nec. Phasellus accumsan, orci id consectetur ultrices, erat mi lobortis tortor, in dapibus erat dolor eget velit. Fusce sagittis magna lectus. Nullam interdum dolor turpis, ut consequat dolor aliquet nec.", width: collectionView.frame.width)
            return CGSize(width: collectionView.frame.width, height: height)
        }
        return (collectionViewLayout as! UICollectionViewFlowLayout).itemSize
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        offeringsCollectionView.delegate = self
        offeringsCollectionView.dataSource = self
        flowlayout.itemSize = CGSize(width: 100, height: 25)
        flowlayout.estimatedItemSize = CGSize(width: 100, height: 25)
        flowlayout.minimumInteritemSpacing = 24
        flowlayout.minimumLineSpacing = 16
        
        reviewsCollectionView.delegate = self
        reviewsCollectionView.dataSource = self
//        reviewsCollectionView.backgroundColor = .green
        
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
        return label.frame.height + 40 + CosmosView().frame.height + 16
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
