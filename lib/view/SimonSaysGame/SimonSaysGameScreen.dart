import 'package:flutter/material.dart';
import 'package:goldfolks/controller/DatabaseController.dart';
import 'package:goldfolks/controller/UserAccountController.dart';

class SimonSaysGameScreen extends StatefulWidget {
  static String id = "SimonSaysGameScreen";
  @override
  _SimonSaysGameScreenState createState() => _SimonSaysGameScreenState();
}

class _SimonSaysGameScreenState extends State<SimonSaysGameScreen> {
  int _tries;
  final DatabaseController db = DatabaseController();
  static int _bestScore = UserAccountController.userDetails.SimonSaysScore;
  int _currScore = 0;

  Widget ScoreWidget() {
    return Container();
  }

  void _startGame() {

  }
  @override
  void initState() {
    super.initState();
    //_startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center (

      ),
    );
  }
}
