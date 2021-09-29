import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goldfolks/controller/DatabaseController.dart';
import 'package:goldfolks/controller/SimonSaysController.dart';
import 'package:goldfolks/controller/UserAccountController.dart';
import 'package:goldfolks/widgets/SimonSaysButton.dart';
import 'package:rxdart/rxdart.dart';

class SimonSaysGameScreen extends StatefulWidget {
  static String id = "SimonSaysGameScreen";
  @override
  _SimonSaysGameScreenState createState() => _SimonSaysGameScreenState();
}

class _SimonSaysGameScreenState extends State<SimonSaysGameScreen> {
  int _tries = 3;
  final DatabaseController db = DatabaseController();
  static int _bestScore = UserAccountController.userDetails.SimonSaysScore;
  int _currScore = 0;
  bool _gameOver = false;

  void _startGame() {
    setState(() {
      _tries = 3;
      _gameOver = false;
      _currScore = 0;
    });
  }
  @override
  void initState() {
    super.initState();
    SimonSaysController.startGame();
    //_startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center (
          child: !_gameOver ?
          Column (
            children: [
              Expanded( // score display
                flex: 1,
                child: StreamBuilder(
                  stream: SimonSaysController.scoreAndLivesStream.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return SizedBox(height: 100, width: 100, child: CircularProgressIndicator());
                    }
                    print(snapshot.data);
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _RemainingTriesWidget(lives: snapshot.data[0]),
                        _ScoreWidget(score: snapshot.data[1]),
                      ],
                    );
                  }
                )
              ),
              Expanded( // Simon Says display
                flex: 2,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      alignment: Alignment.center,
                      child: GridView.count(
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        children: [
                          SimonSaysButton(buttonIndex: 0),
                          SimonSaysButton(buttonIndex: 1),
                          SimonSaysButton(buttonIndex: 2),
                          SimonSaysButton(buttonIndex: 3),
                          SimonSaysButton(buttonIndex: 4),
                          SimonSaysButton(buttonIndex: 5),
                          SimonSaysButton(buttonIndex: 6),
                          SimonSaysButton(buttonIndex: 7),
                          SimonSaysButton(buttonIndex: 8),
                        ]
                      ),
                      ),
                    )
                  )
                ),
              Expanded( // bottom buffer
                flex: 1,
                child: Container (
                  color: Colors.transparent,
                ),
              ),
            ]
          )
              :
          _GameOverScreen(),
        ),
      ),
    );
  }

  Widget _RemainingTriesWidget({lives}) {
    _tries = lives;
    return Expanded(
      flex: 1,
      child:
          SizedBox(
            width: 80,
            height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon( // life 1
                  Icons.favorite,
                  color: _tries > 0 ? Colors.pink : Colors.transparent,
                  size: 24.0,
                ),
                SizedBox(width: 10),
                Icon( // life 2
                  Icons.favorite,
                  color: _tries > 1 ? Colors.pink : Colors.transparent,
                  size: 24.0,
                ),
                SizedBox(width: 10),
                Icon( // life 3
                  Icons.favorite,
                  color: _tries > 2 ? Colors.pink : Colors.transparent,
                  size: 24.0,
                ),
              ],
            )
      ),
    );
  }

  Widget _ScoreWidget({score}) {
    _currScore = score;
    return Expanded(
        flex: 1,
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "$score",
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

  Widget _GameOverScreen() {
    return Column (
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
            padding: EdgeInsets.all(40),
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
              onPressed: () => _startGame(),
            ),
          ),
        ]
    );
  }
}
