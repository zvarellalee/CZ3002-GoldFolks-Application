import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayerScreen extends StatefulWidget {
  static String id = 'VideoPlayerScreen';
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    Map args = ModalRoute.of(context).settings.arguments;
    print(args);
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: args['videoId'],
      params: YoutubePlayerParams(
        autoPlay: true,
        mute: false,
        desktopMode: true,
        privacyEnhanced: true,
        //showControls: false,
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child:Container(
            color: Colors.black,
            alignment: Alignment.center,
            child: YoutubePlayerControllerProvider( // Provides controller to all the widget below it.
              controller: _controller,
              child: YoutubePlayerIFrame(
                aspectRatio: 16 / 9,
              ),
            ),
          ),
        ),
      )
    );
  }
}


