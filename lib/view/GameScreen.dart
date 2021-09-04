import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text("Cognitive Games"),
      ),
      body: Column (
        children: [
          Expanded(
            child: Container(
              color: Colors.black12,
              constraints: BoxConstraints.expand(),
              // TODO: Display game 1
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              constraints: BoxConstraints.expand(),
              // TODO: Display game 2
            ),
          ),
        ],
      ),
    );
  }
}
