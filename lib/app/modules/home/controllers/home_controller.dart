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

  void startRecording() {
    if (isAvailable.value) {
      text.value = ''; // Clear interim text
      speechToText.listen(onResult: (value) {
        text.value =
            value.recognizedWords; // Update interim text as user speaks
      });
      startRecord.value = true; // Indicate recording has started
    }
  }

  void stopRecording() {
    if (startRecord.value) {
      speechToText.stop();
      startRecord.value = false; // Indicate recording has stopped
      if (text.value.isNotEmpty) {
        voiceList.add(text.value); // Add completed sentence to list
      }
      text.value = ''; // Clear interim text for next recording session
    }
  }
}
