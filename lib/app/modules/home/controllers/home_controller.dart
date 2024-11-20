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
    _loadUserName();
    //speechInitialize();
    fetchUsers();
  }

  void _loadUserName() {
    final email = storage.read('userEmail') ?? '';
    userName.value = email.split('@').first;
  }

  // void speechInitialize() async {
  //   isAvailable.value = await speechToText.initialize();
  // }

  // void recognizedWords() {
  //   if (isAvailable.value) {
  //     speechToText.listen(onResult: (value) {
  //       text.value = value.recognizedWords;

  //       // Update the last entry in the voiceList or add the first one
  //       if (voiceList.isEmpty) {
  //         voiceList.add(text.value); // Add the initial recognized sentence
  //       } else {
  //         voiceList[voiceList.length - 1] = text.value; // Continuously update
  //       }
  //     });
  //   }
  // }

  void fetchUsers() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        print("NULL USER");
        return;
      }
      ;

      final snapshot = await _firestore.collection('users').get();

      // Filter out the current user
      final users = snapshot.docs
          .map((doc) => doc.data())
          .where((data) => data['uid'] != currentUser.uid)
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
