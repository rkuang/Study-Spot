'use strict';

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

exports.onCreateReview = functions.firestore
.document('spots/{spotId}/reviews/{reviewId}')
.onCreate(
    (snapshot, _) => {
        const reviewsRef = snapshot.ref.parent
        const spotRef = reviewsRef.parent

        const db = spotRef.firestore

        return db.runTransaction(t => {
            return t.get(spotRef)
            .then(snap => {
                var current = snap.data().num_reviews
                console.log(current)
                t.update(spotRef, {num_reviews: current + 1})
                return null
            });
        });
    });
