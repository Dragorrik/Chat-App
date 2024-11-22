import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeController extends GetxController {
  final storage = GetStorage();
  var userName = ''.obs;
  RxBool startRecord = false.obs;
  final SpeechToText speechToText = SpeechToText();
  RxBool isAvailable = false.obs;
  var text = "".obs;
  var voiceList = [].obs;
  final isSearchActive = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<Map<String, dynamic>> userList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadCurrentUserName();
    fetchUsers();
    updateMissingUserNames();
  }

  void _loadCurrentUserName() async {
    final email = storage.read('userEmail') ?? '';
    final currentUser = _auth.currentUser;

    if (currentUser != null) {
      final userDoc =
          await _firestore.collection('users').doc(currentUser.uid).get();
      if (userDoc.exists) {
        userName.value = userDoc.data()?['userName'] ?? email.split('@').first;
      }
    } else {
      userName.value = email.split('@').first;
    }
    print(userName.value);
  }

  void updateMissingUserNames() async {
    try {
      final querySnapshot = await _firestore.collection('users').get();
      for (final doc in querySnapshot.docs) {
        if (!doc.data().containsKey('userName') || doc['userName'] == null) {
          await _firestore.collection('users').doc(doc.id).update({
            'userName': doc['email'].split('@')[0], // Default to email username
          });
        }
      }
      print("All missing userNames have been updated.");
    } catch (e) {
      print("Error updating missing userNames: $e");
    }
  }

  void fetchUsers() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        print("No current user logged in.");
        return;
      }

      final snapshot = await _firestore.collection('users').get();

      // Filter out the current user and include userName
      final users = snapshot.docs
          .map((doc) {
            final data = doc.data();
            return {
              'uid': data['uid'],
              'email': data['email'],
              'userName': data['userName'] ?? data['email'].split('@').first,
            };
          })
          .where((user) => user['uid'] != currentUser.uid)
          .toList();

      userList.value = users.cast<Map<String, dynamic>>();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch users: $e");
    }
  }

  void startRecording() {
    if (isAvailable.value) {
      text.value = '';
      speechToText.listen(onResult: (value) {
        text.value = value.recognizedWords;
      });
      startRecord.value = true;
    }
  }

  void stopRecording() {
    if (startRecord.value) {
      speechToText.stop();
      startRecord.value = false;
      if (text.value.isNotEmpty) {
        voiceList.add(text.value);
      }
      text.value = '';
    }
  }
}
