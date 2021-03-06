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
        const review_rating = snapshot.data().rating
        const review_environment = snapshot.data().environment
        const reviews_collection = snapshot.ref.parent
        const spot = reviews_collection.parent

        const db = spot.firestore

        return db.runTransaction(t => {
            return t.get(spot)
            .then(snap => {
                const data = snap.data()

                const num_reviews = data.num_reviews
                const new_num_reviews = num_reviews + 1

                const rating = data.rating
                const total_rating = rating * num_reviews
                const new_rating = (total_rating + review_rating) / new_num_reviews

                const environment = data.environment
                const new_environment = {
                    'noise': ((environment.noise*num_reviews)+review_environment.noise) / new_num_reviews,
                    'activity': ((environment.activity*num_reviews)+review_environment.activity) / new_num_reviews,
                    'comfort': ((environment.comfort*num_reviews)+review_environment.comfort) / new_num_reviews
                }

                t.update(spot, 
                    {
                        num_reviews: new_num_reviews,
                        rating: new_rating,
                        environment: new_environment
                    })
                return null
            });
        });
    });
