import 'dart:async';

import 'package:flutter/material.dart';
import 'package:goldfolks/controller/DatabaseController.dart';
import 'package:goldfolks/controller/MentalMathController.dart';
import 'package:goldfolks/controller/ScreenController.dart';
import 'package:goldfolks/controller/UserAccountController.dart';
import 'package:goldfolks/model/AnswerScorePair.dart';
import 'package:goldfolks/model/MathQuestion.dart';

class MentalMathGameScreen extends StatefulWidget {
  static String id = "MentalMathGameScreen";
  @override
  _MentalMathGameScreenState createState() => _MentalMathGameScreenState();
}

class _MentalMathGameScreenState extends State<MentalMathGameScreen> {
  static int _maxTime = 60;
  static int _counter = _maxTime;
  static int _bestScore = UserAccountController.userDetails.MentalMathScore;
  int _currScore = 0;
  int _questionsCorrect = 0;
  int _numQuestions = 0;
  MathQuestion _mathQuestion;
  List<AnswerScorePair> _answersList;
  final DatabaseController db = DatabaseController();
  static Timer _timer;

  /// Reset the timer
  void _startTimer() {
    _resetGame();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (_counter > 0) {
        setState(() {
          _counter --;
        });
      } else { // when timer ends
        _timer.cancel();
        String name = UserAccountController.userDetails.name;
        await ScreenController.UserCntrlAccount.readUserFromDatabase(name);
        if (_currScore > UserAccountController.userDetails.MentalMathScore) {
          await db.updateUserDataMap(name, {"MentalMathScore": _currScore});
          UserAccountController.userDetails.MentalMathScore = _currScore;
          _bestScore = _currScore;
        }
      }
    });
  }

  void _resetGame() {
    setState(() {
      _counter = _maxTime;
      _currScore = 0;
      _mathQuestion = MentalMathController.generateMathQuestion();
      _answersList = MentalMathController.generateChoices(_mathQuestion);
      _questionsCorrect = 0;
      _numQuestions = 0;
    });
  }

  void _submitAnswer(int score) {
    _currScore += score;
    _numQuestions ++;

    if (score > 0) {
      _questionsCorrect ++;
    }

    setState(() {
      _mathQuestion = MentalMathController.generateMathQuestion();
      _answersList = MentalMathController.generateChoices(_mathQuestion);
    });
  }

  Widget AnswerCorrectWidget() {
    return Expanded(
      flex: 1,
      child: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "$_questionsCorrect/$_numQuestions",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              letterSpacing: 2,
              color: Colors.black,
            ),
          ),
          Text(
            "questions",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 2,
              color: Colors.black,
            ),
          ),
        ],
      )
    );
  }

  Widget CountdownWidget() {
    return Expanded(
      flex: 1,
      child: Stack (
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            //alignment: Alignment.center,
            child: CircularProgressIndicator(
              strokeWidth: 5.0,
              value: _counter/_maxTime,
            ),
          ),
          Text(
            '$_counter',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              letterSpacing: 6,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget ScoreWidget() {
    return Expanded(
        flex: 1,
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "$_currScore",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                letterSpacing: 2,
                color: Colors.black,
              ),
            ),
            Text(
              "points",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 2,
                color: Colors.black,
              ),
            ),
          ],
        )
    );
  }

  Widget AnswerWidget(int index) {
    return Container(
      //margin: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          primary: Colors.lightBlueAccent),
        child: Text(
          "${_answersList[index].answer.toInt()}",
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      onPressed: () => _submitAnswer(_answersList[index].score),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope( // if exit forcefully, stop the timer.
      onWillPop: () async {
        setState(() {
          _timer.cancel();
          _counter = _maxTime;
        });
        Navigator.pop(context);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Center (
            child: _counter > 0 ?
            Column (
              children: [
                Expanded( // score display
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AnswerCorrectWidget(),
                      CountdownWidget(),
                      ScoreWidget(),
                    ],
                  ),
                ),
                Expanded( // question display
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    margin: const EdgeInsets.all(10.0),
                    child: Text(
                    "${_mathQuestion.getEquation()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      letterSpacing: 6,
                      color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.white,
                    margin: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AnswerWidget(0),
                        AnswerWidget(1),
                        AnswerWidget(2),
                        AnswerWidget(3),
                      ]
                    )
                  ),
                ),
              ],
            ) :
            Column (
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Your Score: $_currScore",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    letterSpacing: 2,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                    "Best Score: ${_currScore > _bestScore ? _currScore : _bestScore}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      letterSpacing: 2,
                      color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 10, 40, 10),
                  child: ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(primary: Colors.red[300]),
                    child: Padding(
                      padding:
                      const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
                      child: Text('Try Again',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () => _startTimer(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 40.0),
                  child: ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(primary: Colors.red[300]),
                    child: Padding(
                      padding:
                      const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
                      child: Text('Exit',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}

// TODO: Lock orientation in game