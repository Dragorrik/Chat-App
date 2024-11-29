import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String currentUser;
  late String currentUserId; // Use uid for unique identification
  late String chatUser;
  late String chatUserId;
  late String chatId;
  late String userName;

  RxList<QueryDocumentSnapshot<Map<String, dynamic>>> messages = RxList();

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments as Map<String, dynamic>;

    // Fetch userName and chatUser details from arguments
    userName = args['userName'] ?? "Unknown User";
    currentUser = _auth.currentUser?.email ?? "unknown@example.com";
    currentUserId =
        _auth.currentUser?.uid ?? "unknown_user"; // Get current user's UID
    chatUser = args['email'] ?? "unknown@example.com";
    chatUserId = args['uid'] ?? "unknown_user"; // Ensure chatUser UID is passed

    // Generate chat ID by combining user UIDs in a sorted manner
    final ids = [currentUserId, chatUserId]..sort();
    chatId = ids.join('-');

    // Listen for messages in the chat
    _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .listen((snapshot) {
      messages.value =
          snapshot.docs; // Update messages list with document snapshots
    });
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    try {
      // Add message to Firestore
      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add({
        'sender': currentUser,
        'text': text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Update metadata for the chat
      await _firestore.collection('chats').doc(chatId).set({
        'user1': currentUser,
        'user2': chatUser,
        'lastMessage': text.trim(),
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      Get.snackbar('Error', 'Failed to send message: $e');
    }
  }

  void initiateAudioCall() {
    Get.toNamed(
      '/call',
      arguments: {
        'channelId': chatId, // Unique channel ID
        'isVideo': false, // Audio call
      },
    );
  }

  void initiateVideoCall() {
    Get.toNamed(
      '/call',
      arguments: {
        'channelId': chatId, // Unique channel ID
        'isVideo': true, // Video call
      },
    );
  }
}
