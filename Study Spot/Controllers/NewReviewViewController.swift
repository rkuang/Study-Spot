//
//  NewReviewViewController.swift
//  Study Spot
//
//  Created by Ricky Kuang on 12/4/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit
import Cosmos

class NewReviewViewController: UIViewController, UITextViewDelegate {
    
    var titleLabelText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingSlider: CosmosView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func setupViews() {
        titleLabel.text = titleLabelText
        textView.delegate = self
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.textContainer.lineFragmentPadding = 0
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 0 {
            hintLabel.isHidden = true
        } else {
            hintLabel.isHidden = false
        }
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
