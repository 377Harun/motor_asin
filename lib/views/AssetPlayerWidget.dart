import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'VideoPlayerWidget.dart';

class AssetPlayerWidget extends StatefulWidget {
  const AssetPlayerWidget({Key? key}) : super(key: key);

  @override
  _AssetPlayerWidgetState createState() => _AssetPlayerWidgetState();
}

class _AssetPlayerWidgetState extends State<AssetPlayerWidget> {
  VideoPlayerController? controller;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller?.dispose();
  }

  void initState() {
    super.initState();
    controller = VideoPlayerController.asset("images/tirvideo.mp4")
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((_) => controller?.play());
  }

  Widget build(BuildContext context) {
    final ismuted = controller?.value.volume == 0;
    return Column(
      children: [
        VideoPlayerWidget(controller: controller!),
        SizedBox(height: 32),
        if (controller != null && controller!.value.isInitialized)
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.red,
            child: IconButton(
              onPressed: () {
                controller!.setVolume(ismuted ? 1 : 0);
              },
              icon: Icon(
                ismuted ? Icons.volume_mute : Icons.volume_up,
                color: Colors.white,
              ),
            ),
          )
      ],
    );
  }
}
