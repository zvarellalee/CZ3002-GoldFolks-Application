import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatelessWidget {
  static String id = 'VideoPlayerScreen';
  final String videoId;
  const VideoPlayerScreen ({ Key key, this.videoId }): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
      ),
    );
  }
}
