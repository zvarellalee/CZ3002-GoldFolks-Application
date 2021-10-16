import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goldfolks/controller/UserAccountController.dart';
import 'package:goldfolks/view/MentalMathGame/MentalMathGameScreen.dart';
import 'package:goldfolks/view/MentalMathGame/MentalMathTutorialScreen.dart';

import 'MentalMathLeaderboardScreen.dart';

class MentalMathMenuScreen extends StatefulWidget {
  static String id = "MentalMathMenuScreen";
  @override
  _MentalMathMenuScreenState createState() => _MentalMathMenuScreenState();
}

class _MentalMathMenuScreenState extends State<MentalMathMenuScreen> {
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
      extendBodyBehindAppBar: true,
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
        //foregroundColor: Colors.black87,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(40),
        child: SafeArea(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Mental Math",
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
                    "Best Score: ${UserAccountController.userDetails.MentalMathScore}",
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
                        child: Text(
                          'Play',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, MentalMathGameScreen.id)
                              .then(_onGoBack),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
                        child: Text(
                          'Tutorial',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onPressed: () => Navigator.pushNamed(
                          context, MentalMathTutorialScreen.id),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueAccent,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
                        child: Text(
                          'Leaderboard',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onPressed: () => Navigator.pushNamed(
                          context, MentalMathLeaderboardScreen.id),
                    ),
                  ),
                  //onPressed:
                ]),
          ),
        ),
      ),
    );
  }
}
