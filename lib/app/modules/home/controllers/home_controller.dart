import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeController extends GetxController {
  final storage = GetStorage();
  var userName = ''.obs;
  RxBool startRecord = false.obs;
  final SpeechToText speechToText = SpeechToText();
  RxBool isAvailable = false.obs;
  var text = "Nothing to show".obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserName();
    speechInitialize();
  }

  void _loadUserName() {
    final email = storage.read('userEmail') ?? '';
    userName.value = email.split('@').first;
  }

  void speechInitialize() async {
    isAvailable.value = await speechToText.initialize();
  }

  void recognizedWords() {
    if (isAvailable.value) {
      speechToText.listen(onResult: (value) {
        text.value = speechToText.lastRecognizedWords;
      });
    }
  }
}
