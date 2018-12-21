//
//  Review.swift
//  Study Spot
//
//  Created by Ricky Kuang on 12/3/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import FirebaseFirestore

struct Review {
    var rating: Double
    var text: String
    var timestamp: Timestamp
    var noise: Double
    var activity: Double
    var comfort: Double
    
    var dictionary: [String: Any] {
        return [
            "rating": rating,
            "text": text,
            "timestamp": timestamp,
            "noise": noise,
            "activity": activity,
            "comfort": comfort
        ]
    }
}

extension Review {
    init?(dictionary: [String: Any]) {
        guard let rating = dictionary["rating"] as? Double,
            let text = dictionary["text"] as? String,
            let timestamp = dictionary["timestamp"] as? Timestamp,
            let noise = dictionary["noise"] as? Double,
            let activity = dictionary["activity"] as? Double,
            let comfort = dictionary["comfort"] as? Double
        else {
            print("Review could not be instantiated")
            return nil
        }
        self.init(rating: rating, text: text, timestamp: timestamp, noise: noise, activity: activity, comfort: comfort)
    }
}
