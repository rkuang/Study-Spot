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
    
    struct Offering {
        var image: String
        var name: String
    }
    
    let list = [
        Offering(image: "wifi-solid", name: "Free WiFi"),
        Offering(image: "plug-solid", name: "Power Outlets"),
        Offering(image: "pencil-alt-solid", name: "Big Workspace"),
        Offering(image: "lightbulb-solid", name: "Well Lit")
    ]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "offeringsCell", for: indexPath) as! OfferingsCell
        let offering = list[indexPath.row]
        
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

class OfferingsCell : UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.backgroundColor = .green
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .blue
        label.font = UIFont(name: "Futura", size: 17)
        label.textColor = UIColor(white: 0.45, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[image(25@999)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["image": imageView]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["label": label]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[image(25)]-12-[label]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["image": imageView, "label": label]))
        
    }
    
}
