import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class TrailerPlayer extends StatefulWidget {
  final String videoUrl;

  const TrailerPlayer({required this.videoUrl, Key? key}) : super(key: key);

  @override
  State<TrailerPlayer> createState() => TrailerPlayerState();
}

class TrailerPlayerState extends State<TrailerPlayer> with AutomaticKeepAliveClientMixin{
  late VideoPlayerController controller;
  late ChewieController chewieController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.videoUrl);
    chewieController = ChewieController(
      videoPlayerController: controller,
      aspectRatio: 16 / 9,
      autoPlay: true,
    );

    WidgetsBinding.instance
        .addPostFrameCallback((_) => {
          chewieController.enterFullScreen(),
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]),
    });

    chewieController.addListener(() {
      if (!chewieController.isFullScreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
            aspectRatio: 16 / 9, child: Chewie(controller: chewieController)),
      ],
    );
  }
}
