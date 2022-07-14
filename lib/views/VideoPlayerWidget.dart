import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({Key? key, required this.controller})
      : super(key: key);

  final VideoPlayerController controller;

  Widget build(BuildContext context) {
    return controller != null && controller.value.isInitialized
        ? Container(
            alignment: Alignment.center,
            child: buildVideoPlayer(),
          )
        : Container(
            height: 200,
            child: Container(child: CircularProgressIndicator()),
          );
  }

  Widget buildVideo() => Stack(
      //children: [buildVideoPlayer(), BasicOverlayWidget()],
      );

  Widget buildVideoPlayer() => AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: VideoPlayer(controller));
}
