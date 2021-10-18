import 'package:flutter/material.dart';
import 'package:goldfolks/view/SimonSaysGame/SimonSaysMenuScreen.dart';

import 'MentalMathGame/MentalMathMenuScreen.dart';

class GameScreen extends StatelessWidget {
  static String id = 'GamesScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          child: Text(
            'Back',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[200],
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.blueAccent,
        title: Text("Cognitive Games"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(15.0),
          //   child: Text("Cognitive Games",
          //       textScaleFactor: 1.5,
          //       style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         color: Colors.black45.withOpacity(0.8),
          //       )),
          // ),
          Expanded(
            child: Container(
              constraints: BoxConstraints.expand(),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white, shadowColor: Colors.transparent),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.calculate, size: 60),
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
                onPressed: () =>
                    Navigator.pushNamed(context, MentalMathMenuScreen.id),
              ),
              // TODO: Display game 1
            ),
          ),
          Divider(
            height: 20,
            thickness: 5,
            indent: 10,
            endIndent: 10,
            color: Colors.black45.withOpacity(0.5),
          ),
          Expanded(
            child: Container(
              constraints: BoxConstraints.expand(),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white, shadowColor: Colors.transparent),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // TODO: Insert an image for game
                    CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.gamepad, size: 60),
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
                onPressed: () =>
                    Navigator.pushNamed(context, SimonSaysMenuScreen.id),
                // TODO: Display game 2
              ),
            ),
          ),
        ],
      ),
    );
  }
}
