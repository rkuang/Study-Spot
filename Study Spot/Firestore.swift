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
    
    func retrieveStudySpots(_ callback: @escaping (_ studySpots: [StudySpot], _ docRefs: [DocumentReference]) -> Void) {
        self.studySpots.getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var spots = [StudySpot]()
                var docRefs = [DocumentReference]()
                for document in querySnapshot!.documents {
                    if let model = StudySpot(dictionary: document.data()) {
                        // Add model to data source
                        spots.append(model)
                        docRefs.append(document.reference)
                    } else {
                        fatalError("Failed to create StudySpot object")
                    }
                }
                callback(spots, docRefs)
            }
        }
    }
    
    func retrieveReviews(docRef: DocumentReference, _ callback: @escaping (_ reviews: [Review]) -> Void) {
        self.reviews(docRef: docRef).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var reviews = [Review]()
                for document in querySnapshot!.documents {
                    if let model = Review(dictionary: document.data()) {
                        reviews.append(model)
                    } else {
                        fatalError("Could not deserialize Review")
                    }
                }
                callback(reviews)
            }
        }
    }
}
