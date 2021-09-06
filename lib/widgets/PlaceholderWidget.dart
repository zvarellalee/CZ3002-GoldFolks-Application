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
              VideoListWidget("https://www.youtube.com/watch?v=p-rSdt0aFuw"),
            ],
          ),
    );
  }
}