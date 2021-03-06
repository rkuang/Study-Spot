//
//  StudySpot.swift
//  Study Spot
//
//  Created by Ricky Kuang on 11/30/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

struct StudySpot {
    var name: String
    var rating: Double
    var num_reviews: Int
    var environment: [String: Double]
    var offerings: [String]
    
    var dictionary: [String: Any] {
        return [
            "name": name,
            "rating": rating,
            "num_reviews": num_reviews,
            "environment": environment,
            "offerings": offerings
        ]
    }
}

extension StudySpot {
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
            let rating = dictionary["rating"] as? Double,
            let num_reviews = dictionary["num_reviews"] as? Int,
            let environment = dictionary["environment"] as? [String: Double],
            let offerings = dictionary["offerings"] as? [String]
            else { return nil }
        self.init(name: name, rating: rating, num_reviews: num_reviews, environment: environment, offerings: offerings)
    }
}
