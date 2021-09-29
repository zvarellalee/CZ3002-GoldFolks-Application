import 'package:flutter/material.dart';
import 'package:goldfolks/view/SimonSaysGame/SimonSaysMenuScreen.dart';

import 'MentalMathGame/MentalMathMenuScreen.dart';

class GameScreen extends StatelessWidget {
  static String id = 'GamesScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text("Cognitive Games"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              constraints: BoxConstraints.expand(),
              child: ElevatedButton (
                style: ElevatedButton.styleFrom(primary: Colors.black12, shadowColor: Colors.transparent),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // TODO: Insert an image for game
                    CircleAvatar(
                      radius: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Mental Math",
                      textScaleFactor: 1.5,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                onPressed: () => Navigator.pushNamed(context, MentalMathMenuScreen.id),
              ),
              // TODO: Display game 1
            ),
          ),
          Expanded(
            child: Container(
              constraints: BoxConstraints.expand(),
              child: ElevatedButton (
                style: ElevatedButton.styleFrom(primary: Colors.white, shadowColor: Colors.transparent),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // TODO: Insert an image for game
                    CircleAvatar(
                      radius: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Simon Says",
                      textScaleFactor: 1.5,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                onPressed: () => Navigator.pushNamed(context, SimonSaysMenuScreen.id),
                // TODO: Display game 2
              ),
            ),
          ),
        ],
      ),
    );
  }
}
