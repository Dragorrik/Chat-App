import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeController extends GetxController {
  final storage = GetStorage();
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userImageIndex = 6.obs;
  var userOccupation = ''.obs;
  var userPhoneNo = ''.obs;
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
  void onInit() async {
    super.onInit();
    _loadCurrentUserNameAndEmail();
    fetchUsers();
    listenToUsers();
  }

  void _loadCurrentUserNameAndEmail() async {
    final email = storage.read('userEmail') ?? '';
    final currentUser = _auth.currentUser;

    if (currentUser != null) {
      final userDoc =
          await _firestore.collection('users').doc(currentUser.uid).get();
      if (userDoc.exists) {
        userName.value = userDoc.data()?['userName'] ?? email.split('@').first;
        userEmail.value = userDoc.data()?['email'];
        userImageIndex.value = userDoc.data()?['profileImageIndex'];
        userOccupation.value = userDoc.data()?['occupation'];
        userPhoneNo.value = userDoc.data()?['phoneNo'];
      }
    } else {
      userName.value = email.split('@').first;
    }
  }

  void fetchUsers() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) return;

      final snapshot = await _firestore.collection('users').get();

      final users = snapshot.docs
          .map((doc) {
            final data = doc.data();
            final uid = data['uid'];

            return {
              'uid': uid,
              'email': data['email'],
              'userName': data['userName'] ?? data['email'].split('@').first,
              'profileImageIndex': data['profileImageIndex'],
            };
          })
          .where((user) => user['uid'] != currentUser.uid)
          .toList();

      userList.value = users.cast<Map<String, dynamic>>();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch users: $e");
    }
  }

  // Firestore listener for real-time updates
  void listenToUsers() {
    _firestore.collection('users').snapshots().listen((snapshot) {
      userList.clear(); // Clear existing data
      for (var doc in snapshot.docs) {
        if (doc['uid'] == _auth.currentUser?.uid) {
          continue;
        }
        userList.add({
          'uid': doc['uid'],
          'userName': doc['userName'],
          'email': doc['email'],
          'profileImageIndex': doc['profileImageIndex'],
        });
      }
    });
  }

  Future<void> updateUsername(String newUsername) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;
      // Update in Firebase or local database
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId) // Replace with the user's ID
          .update({'userName': newUsername});

      userName.value = newUsername; // Update local state
    } catch (e) {
      Get.snackbar('Error', 'Failed to update username: $e');
    }
  }

  Future<void> updateUserOccupation(String newUserOccupation) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid;
      // Update in Firebase or local database
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId) // Replace with the user's ID
          .update({'occupation': newUserOccupation});

      userOccupation.value = newUserOccupation; // Update local state
    } catch (e) {
      Get.snackbar('Error', 'Failed to update userOccupation: $e');
    }
  }

  Future<void> updateUserPassword(String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user?.updatePassword(newPassword);

      Get.snackbar(
        'Success',
        'Password updated successfully',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update password: $e',
      );
      print('Failed to update password: $e');
    }
  }
}
