//
//  NewReviewViewController.swift
//  Study Spot
//
//  Created by Ricky Kuang on 12/4/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit
import Cosmos

class NewReviewViewController: UIViewController {
    
    var titleLabelText: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingSlider: CosmosView!
    
    func setupViews() {
        titleLabel.text = titleLabelText
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
