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
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 8))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
    
    override func awakeFromNib() {
        self.setThumbImage(UIImage(), for: .normal)
        super.awakeFromNib()
    }

}
