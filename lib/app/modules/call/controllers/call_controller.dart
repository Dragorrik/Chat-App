import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class CallController extends GetxController {
  late RtcEngine agoraEngine; // Agora RTC Engine instance
  String channelName = 'Chatitide'; // Channel Name
  late bool isVideoCall; // Whether it's a video or audio call

  final String appId =
      '47f5dc6037054d6da6c99fb0dd227303'; // Replace with your Agora App ID
  final String token =
      '007eJxTYBCQFb7PK9HYusKr5MttQ8+tftErnePuPpoaeqTbOfmSUp0Cg4l5mmlKspmBsbmBqUmKWUqiWbKlZVqSQUqKkZG5sYHx/q/e6Q2BjAzfCm6wMjJAIIjPyeCckViSWZKZksrAAACqOCFs';
  RxBool isJoined = false.obs;
  RxBool isMuted = false.obs;
  Rxn<int> remoteUid = Rxn<int>(); // Remote user UID (null if no remote user)

  @override
  void onInit() {
    super.onInit();

    // Retrieve arguments from Get.arguments
    final args = Get.arguments as Map<String, dynamic>;
    //channelName = args['channelId'];
    isVideoCall = args['isVideo'];

    // Initialize Agora engine and join the channel
    _initializeAgoraEngine();
  }

  Future<void> _initializeAgoraEngine() async {
    // Initialize permissions
    await _handlePermissions();

    // Initialize Agora RTC engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(
      RtcEngineContext(appId: appId),
    );

    // Set video or audio mode
    if (isVideoCall) {
      await agoraEngine.enableVideo();
    } else {
      await agoraEngine.disableVideo();
    }

    // Set up event listeners (e.g., for connection events)
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          isJoined.value = true;
          print('Successfully joined the channel: $channelName');
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          this.remoteUid.value = remoteUid;
          print('Remote user joined: $remoteUid');
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          this.remoteUid.value = null;
          print('Remote user offline: $remoteUid');
        },
      ),
    );

    // Join the channel
    await agoraEngine.joinChannel(
      token: token,
      channelId: channelName,
      uid: 0, // Local user ID (set to 0 for Agora to auto-assign)
      options: ChannelMediaOptions(),
    );
  }

  Future<void> _handlePermissions() async {
    // Request microphone and camera permissions
    final statuses = await [
      Permission.microphone,
      if (isVideoCall)
        Permission.camera, // Camera is required only for video calls
    ].request();

    if (statuses[Permission.microphone] != PermissionStatus.granted ||
        (isVideoCall &&
            statuses[Permission.camera] != PermissionStatus.granted)) {
      Get.snackbar('Permissions Required',
          'Please grant microphone and camera permissions.');
      throw Exception('Permissions not granted.');
    }
  }

  void toggleMute() {
    isMuted.value = !isMuted.value;
    agoraEngine.muteLocalAudioStream(isMuted.value);
  }

  Future<void> leaveChannel() async {
    await agoraEngine.leaveChannel();
    isJoined.value = false;
    remoteUid.value = null;
    print('Left the channel');
  }

  @override
  void onClose() {
    agoraEngine.release();
    super.onClose();
  }
}
