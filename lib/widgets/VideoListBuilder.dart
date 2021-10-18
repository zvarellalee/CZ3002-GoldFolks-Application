import 'package:flutter/material.dart';
import 'package:goldfolks/controller/VideoPlayerController.dart';
import 'package:goldfolks/model/VideoCategory.dart';

import 'VideoListWidget.dart';

class VideoListBuilder extends StatelessWidget {
  final Color color;
  final VideoCategory category;

  VideoListBuilder(this.color, this.category);
  //List<String> aerobicList = await VideoPlayerController.getAllVideos(VideoCategory.Aerobic)
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: VideoPlayerController.getAllVideos(category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.hasData == null) {
          return Container(
            color: color,
          );
        } else if (snapshot.hasData)
        return Container(
          color: color,
          height: 100.0,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemExtent: 100.0,
              itemCount: snapshot.data.length,
              //TODO : pull videos from database for dynamic loading
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    VideoListWidget(snapshot.data[index]),
                  ],
                );
              }
          )
        );
        else
          return Container(
            color: color,
          );
      }
    );
  }
}