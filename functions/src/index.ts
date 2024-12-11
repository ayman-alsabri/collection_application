/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */


import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

export const addFood = functions.https.onCall(async (request) => {

    let { title, body, foodData } = request.data;
    let { senderData, food, unitIds, unitNames, unitWeights, ingrediantIds, ingrediantWeights, barcode } = foodData;
    try {
        let addUnitsPromises = [];
        let addIngrediantsPromises = [];

        if ((unitIds as string).length) {
            const unitIdsArray = (unitIds as string).split('/');
            const unitNamesArray = (unitNames as string).split('/');
            const unitWeightsArray = (unitWeights as string).split('/');

            for (let i = 0; i < unitIdsArray.length; i++) {

                const newPromise = await admin.firestore().collection('Unit').doc(unitIdsArray[i]).set({
                    'foodId': food.id,
                    'name': unitNamesArray[i],
                    'weight': parseFloat(unitWeightsArray[i])
                })
                addUnitsPromises.push(newPromise);
            }
        }

        if ((ingrediantIds as string).length) {
            const ingrediantIdsArray = (ingrediantIds as string).split('/');
            const ingrediantWeightsArray = (ingrediantWeights as string).split('/');

            for (let i = 0; i < ingrediantIdsArray.length; i++) {

                let newPromise = await admin.firestore().collection('Ingrediant').doc(`${food.id}@${ingrediantIdsArray[i]}`).set({
                    'foodId': parseInt(ingrediantIdsArray[i]),
                    'id': food.id,
                    'weight': parseFloat(ingrediantWeightsArray[i])
                })
                addIngrediantsPromises.push(newPromise);
            }
        }

        const foodPromise = await admin.firestore().collection('Food').doc(`${food.id}`).set(food)
        const pointsPromise = await admin.firestore().collection('users').doc(senderData.email).update({
            'points': senderData.points
        })

        if (barcode) {
            const barcodePromies = await admin.firestore().collection('Product').doc(`${food.id}`).set({
                'id': food.id,
                'barCode': barcode
            })
            await Promise.all([
                ...addUnitsPromises,
                ...addIngrediantsPromises,
                barcodePromies,
                foodPromise,
                pointsPromise
            ]);
        } else {
            await Promise.all([
                ...addUnitsPromises,
                ...addIngrediantsPromises,
                foodPromise,
                pointsPromise

            ]);
        }



        const response = await admin.messaging().send({
            android: { collapseKey: food.id.toString() },
            topic: 'collection_application',
            data: {
                title: title.toString(),
                body: body.toString(),
                foodData: JSON.stringify(foodData),
                'email': senderData.email,
                'mission': 'add',
            },
        });
        console.log("Message sent successfully:", response);
        return { success: true, message: "Notification sent successfully." };
    } catch (error) {
        console.error("Error sending message:", error);
        return { success: false, message: `an error occured ${error}` };

    }
});

export const deleteFood = functions.https.onCall(async (request) => {

    const { senderData, foodId, title, body } = request.data;

    try {

        const UnitsSnapshot = await admin.firestore().collection('Unit')
            .where('foodId', "==", foodId)
            .get();
        const ingrediantsSnapshot = await admin.firestore().collection('Ingrediant')
            .where('id', "==", foodId)
            .get();
        const productsSnapshot = await admin.firestore().collection('Product')
            .where('id', "==", foodId)
            .get();

        const deleteUnitsPromises = UnitsSnapshot.docs.map(doc => doc.ref.delete());
        const deleteIngrediantsPromises = ingrediantsSnapshot.docs.map(doc => doc.ref.delete());
        const deleteProductsPromises = productsSnapshot.docs.map(doc => doc.ref.delete());
        const deleteFoodPromise = await admin.firestore().collection('Food').doc(`${foodId}`).delete()
        const pointsPromise = await admin.firestore().collection('users').doc(senderData.email).update({
            'points': senderData.points
        })

        await Promise.all([
            ...deleteUnitsPromises,
            ...deleteIngrediantsPromises,
            ...deleteProductsPromises,
            deleteFoodPromise,
            pointsPromise
        ]);

        const response = await admin.messaging().send({
            android: { collapseKey: foodId.toString() },
            topic: 'collection_application',
            data: {
                'title': title,
                'body': body,
                'foodId': foodId.toString(),
                'senderEmail': senderData.email,
                'mission': 'delete',
            },
        });
        console.log("Message sent successfully:", response);
        return { success: true, message: "Notification sent successfully." };
    } catch (error) {

        console.error("Error sending message:", error);
        return { success: false, message: `an error occured ${error}` };

    }
});


// Start writing functions
// https://firebase.google.com/docs/functions/typescript

// export const helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
