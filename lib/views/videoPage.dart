import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final String name;
  final String videoKey;

  VideoPlayer({
    Key? key,
    required this.name,
    required this.videoKey,
  }) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();

}

class _VideoPlayerState extends State<VideoPlayer> {
  bool isFullScreen = false;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=${widget.videoKey}")!,
      flags: const YoutubePlayerFlags(
          hideControls: false,
          controlsVisibleAtStart: true,
          autoPlay: true,
          mute: false
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isFullScreen == true ? null : AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: YoutubePlayerBuilder(
              onEnterFullScreen: (){
                setState((){
                  isFullScreen = true;
                });
              },
              onExitFullScreen: (){
                setState((){
                  isFullScreen = false;
                });
              },
              player: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: const Color(0xFFFCF4E1),
              ),
              builder: (context, player) {
                return Column(
                  children: [
                    player
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
