import 'package:chatapp/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  // get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // send message
  Future<void> sendMessage(String receiverId, String message) async {
    // get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create new message
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp);

    // create chat room id from current uid and receiver uid (sort for uniqueness)
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // so chat rooms are always the same
    String chatRoomId = ids.join("_");

    // add new message to database
    await _fireStore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(
          newMessage.toMap(),
        );

    // await _fireStore
    //     .collection("users")
    //     .doc(currentUserId)
    //     .update({"lastest_message": message});

    // await _fireStore
    //     .collection("users")
    //     .doc(receiverId)
    //     .update({"lastest_message": message});

    await _fireStore
        .collection("users")
        .doc(currentUserId)
        .update({"messages_sent": FieldValue.increment(1)});

    // FieldValue.increment(value)
  }

  // get messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    // create room for userId and otherUserId
    List<String> ids = [userId, otherUserId];
    ids.sort(); // so chat rooms are always the same
    String chatRoomId = ids.join("_");

    return _fireStore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }
}
