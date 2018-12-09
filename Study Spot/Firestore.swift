//
//  Firestore.swift
//  Study Spot
//
//  Created by Ricky Kuang on 12/5/18.
//  Copyright © 2018 Ricky Kuang. All rights reserved.
//

import FirebaseFirestore

extension Firestore {
    
    public var studySpots: CollectionReference {
        return self.collection("spots")
    }
    
    public func reviews(docRef: DocumentReference) -> CollectionReference {
        return docRef.collection("reviews")
    }
    
}
