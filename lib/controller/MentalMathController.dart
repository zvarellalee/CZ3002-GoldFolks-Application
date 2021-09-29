import 'dart:math';

import 'package:goldfolks/model/AnswerScorePair.dart';
import 'package:goldfolks/model/MathQuestion.dart';
import 'package:goldfolks/model/UserAccount.dart';

import 'DatabaseController.dart';

class MentalMathController {
  static int _maxValue = 21; // max value for math question operands
  static final _rng = new Random();
  static final _range = 10;

  /// Generates a math question and returns it as a string
  static MathQuestion generateMathQuestion() {
    int operator = _rng.nextInt(4);
    int operand1, operand2;
    int temp;
    switch (operator) {
      case 0: // addition, subtraction, multiplication
      case 1:
      case 2:
        operand1 = _rng.nextInt(_maxValue); // TODO: if including negative operands
        operand2 = _rng.nextInt(_maxValue);
        break;
      case 3:
        operand2 = _rng.nextInt(_maxValue);
        temp = _rng.nextInt(_maxValue);
        operand1 = (operand2*temp).toInt();
        break;
      default:

    }
    //int operator = _rng.nextInt(3); // TODO: generate only factors for division?

    return new MathQuestion(
      operand1: operand1,
      operand2: operand2,
      operator: operator,
    );
  }

  // Generate the questions for a given math question
  static List<AnswerScorePair> generateChoices(MathQuestion question) {
    List<AnswerScorePair> choiceList = [];
    int answer, minR, maxR;
    double gen;
    answer = question.answerInt;
    double dAnswer = question.answerDouble;
    minR = answer-_range; // TODO: if including negative answers...
    maxR = (answer+_range).abs();
    choiceList.add(new AnswerScorePair(answer: question.answerDouble, score: question.score,));
    for (int i = 0; i<3; i++) {
      gen = _next(minR, maxR);
      while (gen == answer) { // don't generate the same answer as the actual answer.
        gen = _next(minR, maxR);
      }
      choiceList.add(new AnswerScorePair(answer: _next(minR, maxR), score: 0));
    }
    choiceList.shuffle();
    return choiceList;
  }

  static double _next(int min, int max) {
      return (min + _rng.nextInt(max - min)).toDouble();
  }
}