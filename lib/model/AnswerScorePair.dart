class AnswerScorePair {
  double _answer;
  int _score;

  AnswerScorePair({
  double answer,
  int score,
  }) :  _answer = answer,
        _score = score;

  double get answer => _answer;
  int get score => _score;

  set answer(double answer) => _answer = answer;
  set score(int score) => _score = score;
}

