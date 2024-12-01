import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_type_project/app/modules/call/controllers/call_controller.dart';

class CallView extends GetView<CallController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1D1D1D),
      body: SafeArea(
        child: Stack(
          children: [
            // Video feed or placeholder
            Obx(() {
              if (controller.isVideoCall) {
                return controller.isJoined.value
                    ? Stack(
                        children: [
                          // Remote user video
                          if (controller.remoteUid.value != null)
                            AgoraVideoView(
                              controller: VideoViewController.remote(
                                rtcEngine: controller.agoraEngine,
                                canvas: VideoCanvas(
                                  uid: controller.remoteUid.value!,
                                ),
                                connection: RtcConnection(
                                  channelId: controller.channelName,
                                  localUid: 0,
                                ),
                              ),
                            )
                          else
                            const Center(
                              child: Text(
                                "Waiting for the other user to join...",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                          // Local user video
                          Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: 120,
                              height: 160,
                              child: AgoraVideoView(
                                controller: VideoViewController(
                                  rtcEngine: controller.agoraEngine,
                                  canvas: const VideoCanvas(
                                      uid: 0), // Local user UID
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: Text(
                          "Joining channel...",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      );
              } else {
                // Placeholder for audio call
                return Center(
                  child: Text(
                    controller.isJoined.value
                        ? "Audio Call - Connected"
                        : "Joining channel...",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                );
              }
            }),

            // Call controls
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Mute button
                    Obx(() {
                      return CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        child: IconButton(
                          icon: Icon(
                            controller.isMuted.value
                                ? Icons.mic_off
                                : Icons.mic,
                            color: Colors.white,
                          ),
                          onPressed: controller.toggleMute,
                        ),
                      );
                    }),

                    // End call button
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      child: IconButton(
                        icon: const Icon(Icons.call_end, color: Colors.white),
                        onPressed: () async {
                          await controller.leaveChannel();
                          Get.back(); // Navigate back after ending the call
                        },
                      ),
                    ),

                    // Toggle camera (only for video calls)
                    if (controller.isVideoCall)
                      CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        child: IconButton(
                          icon: const Icon(Icons.switch_camera,
                              color: Colors.white),
                          onPressed: () =>
                              controller.agoraEngine.switchCamera(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
