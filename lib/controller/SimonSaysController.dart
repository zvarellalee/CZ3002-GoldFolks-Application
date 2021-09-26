import 'dart:math';

class SimonSaysController {
  static final _rng = new Random();
  static final _numSquares = 9;

  List<int> addNextMove(List<int> list) {
    list.add(_rng.nextInt(_numSquares));
    return list;
  }
}