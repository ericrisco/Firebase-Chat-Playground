const functions = require("firebase-functions");
const admin = require('firebase-admin')

admin.initializeApp();

exports.helloWorld = functions.https.onRequest((req, res) => {
    res.send("Hello Keepcoders")
});

exports.newMessage = functions.database.ref('/messages/{discussionId}/{messageId}').onWrite((event, context) => {

    const discussionId = context.params.discussionId;
    const messageId = context.params.messageId;

    const message = event.after.val();

    var value = message.type == "image" ? "This is an  image" : message.value;

    const payload = {
        notification: {
            title: message.displayName,
            body: value
        }
    }

    const sendPushNotification = admin.messaging().sendToTopic("GENERAL", payload)
    const setNewLastMessageDiscussion = admin.database().ref(`/discussions/${discussionId}/lastMessage`).set(value)

    return Promise.all([setNewLastMessageDiscussion, sendPushNotification])

});

