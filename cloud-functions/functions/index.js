const functions = require("firebase-functions");

// // The Firebase Admin SDK to access Firestore.
// const admin = require('firebase-admin');

// admin.initializeApp();

// const https = require('https');

// Process to the mobile money payment with the given phone number and amount
exports.mobileMoneyPayment = functions.https.onCall(
    (data, context) => {
        if (data === undefined || data === null) {
            return {
                message: 'Aucune donnée reçue',
                status: false,
            }
        } else {
            return {
                message: 'Successfully created new user',
                status: true,
            }
        }
    }
);
