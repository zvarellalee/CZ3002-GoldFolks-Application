import 'package:flutter/material.dart';

import 'VideoListWidget.dart';

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: color,
          child: Column(
            children: [
              Container(
                height: 100.0,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemExtent: 100.0,
                  itemCount: 1, //TODO : pull videos from database for dynamic loading
                  itemBuilder: (BuildContext context, int index) {
                    return VideoListWidget("https://www.youtube.com/watch?v=p-rSdt0aFuw");
                    }
                )
              )
            ],
          ),
    );
  }
}