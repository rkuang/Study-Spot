//
//  CustomSlider.swift
//  Study Spot
//
//  Created by Ricky Kuang on 11/27/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import UIKit

class CustomSlider: UISlider {

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var newBounds = super.trackRect(forBounds: bounds)
        newBounds.size.height = 5.0
        return newBounds
    }
    
    override func awakeFromNib() {
//        self.clearThumbImage()
        super.awakeFromNib()
    }
    
    func clearThumbImage() {
        self.setThumbImage(UIImage(), for: .normal)
    }

}
