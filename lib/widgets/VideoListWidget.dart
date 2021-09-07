import 'package:flutter/material.dart';
import 'package:goldfolks/controller/VideoDetailFetcher.dart';

class VideoListWidget extends StatefulWidget {
  final String url;

  VideoListWidget(this.url);
  @override
  _VideoListWidgetState createState() => _VideoListWidgetState();
}

class _VideoListWidgetState extends State<VideoListWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children;
    return FutureBuilder<dynamic>(
      future: VideoDetailFetcher.getVideoInfo(widget.url),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          children = <Widget>[
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    snapshot.data["title"],
                    textScaleFactor: 1.25,
                    style: TextStyle(color: Colors.black,),
                  ),
                  //Text(snapshot.data["description"],),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                //flex: 1,
                child: AspectRatio(
                  aspectRatio: 1/1,
                  child: Image.network(snapshot.data["thumbnail_url"],
                      fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            Text("Error"),
          ];
        } else {
          children = <Widget> [
            CircularProgressIndicator(),
          ];
        }
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder> (
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color> (
                      Colors.white),
                  fixedSize: MaterialStateProperty.all<Size> (
                    Size(double.infinity, 30),
                  )
              ),
            ),
          ),
        );
      }

    );
  }
}

