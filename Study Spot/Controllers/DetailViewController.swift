//
//  DetailViewController.swift
//  Study Spot
//
//  Created by Ricky Kuang on 11/27/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit
import DGCollectionViewLeftAlignFlowLayout

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var flowlayout: DGCollectionViewLeftAlignFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    let offerings = [
        Offering(image: "wifi-solid", name: "Free WiFi"),
        Offering(image: "plug-solid", name: "Power Outlets"),
        Offering(image: "pencil-alt-solid", name: "Big Workspace"),
        Offering(image: "lightbulb-solid", name: "Well Lit")
    ]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offeringsCell", for: indexPath) as! OfferingsCell
        let offering = offerings[indexPath.row]
        
        cell.imageView.image = UIImage(named: offering.image)
        cell.label.text = offering.name
        
        print(offering.name)
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        flowlayout.itemSize = CGSize(width: 100, height: 25)
        flowlayout.estimatedItemSize = CGSize(width: 100, height: 25)
        flowlayout.minimumInteritemSpacing = 24
        flowlayout.minimumLineSpacing = 16
        
        collectionViewHeight.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
        view.setNeedsLayout()
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
