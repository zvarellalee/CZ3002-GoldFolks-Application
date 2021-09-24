import 'dart:math';

import 'package:goldfolks/model/MathQuestion.dart';

class MentalMathController {
  static int _currScore;
  static int _maxValue = 21; // max value for math question operands
  static final _rng = new Random();
  static final _range = 10;

  /// Generates a math question and returns it as a string
  static Future<MathQuestion> generateMathQuestion() async {
    int operand1 = _rng.nextInt(_maxValue); // TODO: if including negative operands
    int operand2 = _rng.nextInt(_maxValue);
    int operator = _rng.nextInt(3); // TODO: generate only factors for division?

    return new MathQuestion(
      operand1: operand1,
      operand2: operand2,
      operator: operator,
    );
  }

  static Future<List<double>> generateChoices(MathQuestion question) async {
    List choiceList = [];
    int answer = question.answerInt;
    int minR = max(0, answer-_range); // TODO: if including negative answers...
    int maxR = answer+_range;
    choiceList.add(answer);
    for (int i = 0; i<2; i++) {
      choiceList.add(_next(minR, maxR));
    }
    choiceList.shuffle();
    return choiceList;
  }

  static int _next(int min, int max) => min + _rng.nextInt(max - min);
}