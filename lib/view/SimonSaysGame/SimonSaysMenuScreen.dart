import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goldfolks/controller/UserAccountController.dart';
import 'package:goldfolks/view/SimonSaysGame/SimonSaysLeaderboardScreen.dart';

import 'SimonSaysGameScreen.dart';
import 'SimonSaysTutorialScreen.dart';

class SimonSaysMenuScreen extends StatefulWidget {
  static String id = "SimonSaysMenuScreen";
  @override
  _SimonSaysMenuScreenState createState() => _SimonSaysMenuScreenState();
}

class _SimonSaysMenuScreenState extends State<SimonSaysMenuScreen> {

  FutureOr _onGoBack(dynamic value) {
    // TODO: get Best Score to update correctly.
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        //foregroundColor: Colors.black87,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: SafeArea(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Simon Says",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      letterSpacing: 3,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Best Score: ${UserAccountController.userDetails.SimonSaysScore}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 2,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
                      child: Text('Play',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(context, SimonSaysGameScreen.id).then(_onGoBack),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
                      child: Text('Tutorial',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(
                            context, SimonSaysTutorialScreen.id),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
                      child: Text('Leaderboard',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onPressed: () =>
                        Navigator.pushNamed(
                            context, SimonSaysLeaderboardScreen.id),
                  ),
                  //onPressed:
                ]
            ),
          ),
        ),
      ),
    );
  }
}