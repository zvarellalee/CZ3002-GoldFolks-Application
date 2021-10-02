import 'dart:async';
import 'dart:math';

import 'package:rxdart/rxdart.dart';

import 'DatabaseController.dart';
import 'UserAccountController.dart';

class SimonSaysController {
  static final _rng = new Random();
  static final _numSquares = 9;
  static List<int> _sequence = [];
  static int _playIndex = 0;
  static StreamController<int> _animationController = new BehaviorSubject();
  static Timer _timer;
  static Duration _animationInterval = Duration(seconds: 1);
  static StreamController<List<int>> _scoreAndLivesStream = new BehaviorSubject();
  static bool _canPlay = false;
  static int _animationIndex = 0;
  static int _lives;
  static int _score;
  static final DatabaseController db = DatabaseController();

  static List<int> _addNextMove() {
    _sequence.add(_rng.nextInt(_numSquares));
  }

  static void openStream() {
    _animationController = new BehaviorSubject();
    _scoreAndLivesStream = new BehaviorSubject();
  }

  static void closeStream() {
    _animationController.close();
    _scoreAndLivesStream.close();
    _stopTimer();
  }

  static void startGame() {
    resetGame();
    _stopTimer();
    _addNextMove();
    _playAnimation();
  }

  static void endGame() async{
    String name = UserAccountController.userDetails.name;
    await UserAccountController.readUserFromDatabase(name);
    if (_score > UserAccountController.userDetails.SimonSaysScore) {
      await db.updateUserDataMap(name, {"SimonSaysScore":_score});
      UserAccountController.userDetails.SimonSaysScore = _score;
    }
    _scoreAndLivesStream.add([-1,_score]); // -1 signifies end of game.
  }

  static bool checkMove(int index) {
    if (_canPlay) {
      if (_sequence[_playIndex] == index) {
        _playIndex++;
        //print(_sequence);
        //print(_playIndex);
        if (_playIndex == _sequence.length) { // if successfully tapped until last sequence...
          _score += 1;
          _playIndex = 0;
          _scoreAndLivesStream.add([_lives,_score]);
          _addNextMove(); // add a new move to the list.
          _playAnimation(); // this also stops the player from playing
        }
      } else {
        if (_lives == 0) {
          endGame();
        } else {
          _lives--;
          _playIndex = 0;
          _scoreAndLivesStream.add([_lives,_score]);
          _playAnimation();
        }
      }
    }
  }

  static void _playAnimation() {
    _canPlay = false;
    _timer = Timer.periodic(_animationInterval, _tick);
  }

  static void _tick(_) {
    if (_animationIndex < _sequence.length) {
      _animationController.add(_sequence[_animationIndex]);
    }
    _animationIndex++;
    if (_animationIndex >= _sequence.length+1) _stopTimer();
  }

  static void _stopTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
      _animationIndex = 0;
      //_animationController.close();
    }
    _canPlay = true;
  }

  static void resetGame() {
    _animationIndex = 0;
    _sequence.clear();
    _playIndex = 0;
    _lives = 3;
    _score = 0;
    _scoreAndLivesStream.add([_lives,_score]);

  }

  static set canPlay(bool canPlay) => _canPlay = canPlay;

  static get score => _score;

  static bool get canPlay => _canPlay;

  static StreamController<int> get controller => _animationController;

  static StreamController<List<int>> get scoreAndLivesStream => _scoreAndLivesStream;
}