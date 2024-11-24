import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
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
  late Box profileImageBox;

  @override
  void onInit() async {
    super.onInit();
    await _initHive();
    _loadCurrentUserName();
    fetchUsers();
  }

  Future<void> _initHive() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    profileImageBox = await Hive.openBox('profileImages');
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

            // Get profile image from Hive
            final profileImage = getProfileImage(uid);

            return {
              'uid': uid,
              'email': data['email'],
              'userName': data['userName'] ?? data['email'].split('@').first,
              'profileImage': profileImage, // Get the locally stored image
            };
          })
          .where((user) => user['uid'] != currentUser.uid)
          .toList();

      userList.value = users.cast<Map<String, dynamic>>();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch users: $e");
    }
  }

  Future<void> saveProfileImage(String uid, String imagePath) async {
    await profileImageBox.put(uid, imagePath);
    fetchUsers(); // Refresh user list to reflect updated images
  }

  String? getProfileImage(String uid) {
    return profileImageBox.get(uid);
  }
}
