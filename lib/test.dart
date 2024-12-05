import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final Color? color;
  final Color? borderColor;
  final String? title;
  final TextStyle? textStyle;
  final Function()? onTap;

  const PrimaryButton({
    super.key,
    this.height,
    this.width,
    this.radius,
    this.color,
    this.title,
    this.onTap,
    this.textStyle,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 30,
        width: width ?? 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 6),
            color: color ?? Colors.teal,
            border: Border.all(color: borderColor ?? Colors.transparent)),
        child: Center(
          child: Text(
            title ?? "Button",
            style: textStyle ?? TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
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






// late RtcEngine agoraEngine; // Agora RTC Engine instance
  // String channelName = 'Chatitide'; // Channel Name
  // late bool isVideoCall; // Whether it's a video or audio call

  // final String appId =
  //     '47f5dc6037054d6da6c99fb0dd227303'; // Replace with your Agora App ID
  // final String token =
  //     '007eJxTYBCQFb7PK9HYusKr5MttQ8+tftErnePuPpoaeqTbOfmSUp0Cg4l5mmlKspmBsbmBqUmKWUqiWbKlZVqSQUqKkZG5sYHx/q/e6Q2BjAzfCm6wMjJAIIjPyeCckViSWZKZksrAAACqOCFs';
  // RxBool isJoined = false.obs;
  // RxBool isMuted = false.obs;
  // Rxn<int> remoteUid = Rxn<int>(); // Remote user UID (null if no remote user)

  // @override
  // void onInit() {
  //   super.onInit();

  //   // Retrieve arguments from Get.arguments
  //   final args = Get.arguments as Map<String, dynamic>;
  //   //channelName = args['channelId'];
  //   isVideoCall = args['isVideo'];

  //   // Initialize Agora engine and join the channel
  //   _initializeAgoraEngine();
  // }

  // Future<void> _initializeAgoraEngine() async {
  //   // Initialize permissions
  //   await _handlePermissions();

  //   // Initialize Agora RTC engine
  //   agoraEngine = createAgoraRtcEngine();
  //   await agoraEngine.initialize(
  //     RtcEngineContext(appId: appId),
  //   );

  //   // Set video or audio mode
  //   if (isVideoCall) {
  //     await agoraEngine.enableVideo();
  //   } else {
  //     await agoraEngine.disableVideo();
  //   }

  //   // Set up event listeners (e.g., for connection events)
  //   agoraEngine.registerEventHandler(
  //     RtcEngineEventHandler(
  //       onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
  //         isJoined.value = true;
  //         print('Successfully joined the channel: $channelName');
  //       },
  //       onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
  //         this.remoteUid.value = remoteUid;
  //         print('Remote user joined: $remoteUid');
  //       },
  //       onUserOffline: (RtcConnection connection, int remoteUid,
  //           UserOfflineReasonType reason) {
  //         this.remoteUid.value = null;
  //         print('Remote user offline: $remoteUid');
  //       },
  //     ),
  //   );

  //   // Join the channel
  //   await agoraEngine.joinChannel(
  //     token: token,
  //     channelId: channelName,
  //     uid: 0, // Local user ID (set to 0 for Agora to auto-assign)
  //     options: ChannelMediaOptions(),
  //   );
  // }

  // Future<void> _handlePermissions() async {
  //   // Request microphone and camera permissions
  //   final statuses = await [
  //     Permission.microphone,
  //     if (isVideoCall)
  //       Permission.camera, // Camera is required only for video calls
  //   ].request();

  //   if (statuses[Permission.microphone] != PermissionStatus.granted ||
  //       (isVideoCall &&
  //           statuses[Permission.camera] != PermissionStatus.granted)) {
  //     Get.snackbar('Permissions Required',
  //         'Please grant microphone and camera permissions.');
  //     throw Exception('Permissions not granted.');
  //   }
  // }

  // void toggleMute() {
  //   isMuted.value = !isMuted.value;
  //   agoraEngine.muteLocalAudioStream(isMuted.value);
  // }

  // Future<void> leaveChannel() async {
  //   await agoraEngine.leaveChannel();
  //   isJoined.value = false;
  //   remoteUid.value = null;
  //   print('Left the channel');
  // }

  // @override
  // void onClose() {
  //   agoraEngine.release();
  //   super.onClose();
  // }





// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1D1D1D),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Video feed or placeholder
//             Obx(() {
//               if (controller.isVideoCall) {
//                 return controller.isJoined.value
//                     ? Stack(
//                         children: [
//                           // Remote user video
//                           if (controller.remoteUid.value != null)
//                             AgoraVideoView(
//                               controller: VideoViewController.remote(
//                                 rtcEngine: controller.agoraEngine,
//                                 canvas: VideoCanvas(
//                                   uid: controller.remoteUid.value!,
//                                 ),
//                                 connection: RtcConnection(
//                                   channelId: controller.channelName,
//                                   localUid: 0,
//                                 ),
//                               ),
//                             )
//                           else
//                             const Center(
//                               child: Text(
//                                 "Waiting for the other user to join...",
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),

//                           // Local user video
//                           Align(
//                             alignment: Alignment.topLeft,
//                             child: SizedBox(
//                               width: 120,
//                               height: 160,
//                               child: AgoraVideoView(
//                                 controller: VideoViewController(
//                                   rtcEngine: controller.agoraEngine,
//                                   canvas: const VideoCanvas(
//                                       uid: 0), // Local user UID
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     : const Center(
//                         child: Text(
//                           "Joining channel...",
//                           style: TextStyle(fontSize: 18, color: Colors.white),
//                         ),
//                       );
//               } else {
//                 // Placeholder for audio call
//                 return Center(
//                   child: Text(
//                     controller.isJoined.value
//                         ? "Audio Call - Connected"
//                         : "Joining channel...",
//                     style: const TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                     ),
//                   ),
//                 );
//               }
//             }),

//             // Call controls
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     // Mute button
//                     Obx(() {
//                       return CircleAvatar(
//                         backgroundColor: Colors.deepPurple,
//                         child: IconButton(
//                           icon: Icon(
//                             controller.isMuted.value
//                                 ? Icons.mic_off
//                                 : Icons.mic,
//                             color: Colors.white,
//                           ),
//                           onPressed: controller.toggleMute,
//                         ),
//                       );
//                     }),

//                     // End call button
//                     CircleAvatar(
//                       backgroundColor: Colors.red,
//                       child: IconButton(
//                         icon: const Icon(Icons.call_end, color: Colors.white),
//                         onPressed: () async {
//                           await controller.leaveChannel();
//                           Get.back(); // Navigate back after ending the call
//                         },
//                       ),
//                     ),

//                     // Toggle camera (only for video calls)
//                     if (controller.isVideoCall)
//                       CircleAvatar(
//                         backgroundColor: Colors.deepPurple,
//                         child: IconButton(
//                           icon: const Icon(Icons.switch_camera,
//                               color: Colors.white),
//                           onPressed: () =>
//                               controller.agoraEngine.switchCamera(),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }