import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/video_call_controller.dart';

class VideoCallView extends GetView<VideoCallController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<VideoCallController>(
          builder: (_) {
            return Stack(
              children: [
                Center(
                  child: _remoteVideo(controller),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 100,
                    height: 150,
                    child: Center(
                      child: controller.localUserJoined
                          ? _localPreview(controller)
                          : CircularProgressIndicator(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: Container(
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                          onPressed: controller.toggleLotcalAudioMuted,
                          child: controller.localAudioMute == false
                              ? Icon(Icons.mic)
                              : Icon(Icons.mic_off),
                          heroTag: 'micOff',
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: controller.switchCamera,
                          child: Icon(Icons.switch_camera),
                          heroTag: 'cameraSwitch',
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            controller.endMeeting();
                          },
                          child: Icon(Icons.call_end),
                          backgroundColor: Colors.red,
                          heroTag: 'endMeeting',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

// Display local video preview
  Widget _localPreview(VideoCallController controller) {
    if (controller.localUserJoined) {
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: controller.engine,
          canvas: VideoCanvas(
            uid: 0,
          ),
        ),
      );
    } else {
      return const Text(
        'join a channel',
        textAlign: TextAlign.center,
      );
    }
  }

// Display remote user's video
  Widget _remoteVideo(VideoCallController controller) {
    if (controller.remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: controller.engine,
          canvas: VideoCanvas(uid: controller.remoteUid),
          connection: RtcConnection(channelId: controller.room),
        ),
      );
    } else {
      String msg = '';
      if (controller.localUserJoined) msg = 'Waiting for a remote user to join';
      return Text(
        msg,
        textAlign: TextAlign.center,
      );
    }
  }
}
