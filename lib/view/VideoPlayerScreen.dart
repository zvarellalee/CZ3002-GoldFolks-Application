import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatelessWidget {
  static String id = 'VideoPlayerScreen';
  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    print(args);
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: args['videoId'],
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
          ),
            builder: (context, player) {
              return Column(
                children: [
                  player,
                ],
              );
            },
          ),
        ),
      );
  }
}
