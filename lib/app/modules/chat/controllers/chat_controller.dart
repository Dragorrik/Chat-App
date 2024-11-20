import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String currentUser;
  late String chatUser;
  late String chatId;
  RxList<QueryDocumentSnapshot<Map<String, dynamic>>> messages = RxList();

  @override
  void onInit() {
    super.onInit();
    currentUser = _auth.currentUser!.email!;
    chatUser = Get.arguments; // Email of the user to chat with

    // Generate chat ID by combining user emails in a sorted manner
    final ids = [currentUser, chatUser]..sort();
    chatId = ids.join('-');

    // Listen for messages in the chat
    _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .listen((snapshot) {
      messages.value = snapshot.docs;
    });
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'sender': currentUser,
      'text': text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Ensure chat metadata is updated
    await _firestore.collection('chats').doc(chatId).set({
      'user1': currentUser,
      'user2': chatUser,
    }, SetOptions(merge: true));
  }
}
