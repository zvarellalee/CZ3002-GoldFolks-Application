import 'dart:math';

import 'package:goldfolks/model/AnswerScorePair.dart';
import 'package:goldfolks/model/MathQuestion.dart';

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
      case 3: // division
        operand2 = _rng.nextInt(_maxValue);
        temp = _rng.nextInt(_maxValue)+1;
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
    Set<int> distinctNums = new Set();
    int answer, minR, maxR;
    int gen;
    answer = question.answerInt;
    minR = answer-_range; // TODO: if including negative answers...
    maxR = (answer+_range).abs();
    distinctNums.add(answer);
    choiceList.add(new AnswerScorePair(answer: question.answerDouble, score: question.score,));
    // better, utilizes set for O(1) checking
    for (int i = 0; i<3; i++) {
      gen = _next(minR, maxR).toInt();
      while (distinctNums.contains(gen)) { // don't generate the same answer as the actual answer.
        gen = _next(minR, maxR).toInt();
      }
      choiceList.add(new AnswerScorePair(answer: gen.toDouble(), score: 0));
      distinctNums.add(gen);
    }
    choiceList.shuffle();
    return choiceList;
  }

  static double _next(int min, int max) {
      return (min + _rng.nextInt(max - min)).toDouble();
  }
}