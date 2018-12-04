//
//  Review.swift
//  Study Spot
//
//  Created by Ricky Kuang on 12/3/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

struct Review {
    var rating: Double
    var text: String
    
    var dictionary: [String: Any] {
        return [
            "rating": rating,
            "text": text
        ]
    }
}

extension Review {
    init?(dictionary: [String: Any]) {
        guard let rating = dictionary["rating"] as? Double,
            let text = dictionary["text"] as? String
            else { return nil }
        self.init(rating: rating, text: text)
    }
}
