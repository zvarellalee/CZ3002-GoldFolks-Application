import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
          title: Text("Cognitive Games"),
          backgroundColor: Colors.blueAccent,
      ),
      body: Column (
        children: [
          Expanded(
            child: Container(
              color: Colors.black12,
              constraints: BoxConstraints.expand(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ // TODO: Insert an image for game
                  CircleAvatar(
                    radius: 50,
                  ),
                  SizedBox(
                    height:10,
                  ),
                  Text("Mental Math", textScaleFactor: 1.5, ),
                ],
              ),
              // TODO: Display game 1
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              constraints: BoxConstraints.expand(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ // TODO: Insert an image for game
                  CircleAvatar(
                    radius: 50,
                  ),
                  SizedBox(
                    height:10,
                  ),
                  Text("Simon Says", textScaleFactor: 1.5,),
                ],
              // TODO: Display game 2
              ),
            ),
          ),
        ],
      ),
    );
  }
}
