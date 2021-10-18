class MathQuestion {
  int _operand1;
  int _operand2;
  int _operator; // 0 = addition, 1 = sub, 2 = mul, 3 = div
  double _answer;
  int _score; // score for a correct answer

  MathQuestion({
    int operand1,
    int operand2,
    int operator,
  }) {
  _operand1 = operand1;
  _operand2 = operand2;
  _operator  = operator;
  switch (_operator) {
    case 0:
      _answer =  (operand1 + operand2).toDouble();
      _score = 10;
      break;
    case 1:
      _answer = (operand1 - operand2).toDouble();
      _score = 10;
      break;
    case 2:
      _answer = (operand1 * operand2).toDouble();
      _score = 20;
      break;
    case 3:
      _answer = operand1 / operand2;
      _score = 20;
      break;
    default:
      _answer =  (operand1 + operand2).toDouble();
      _score = 10;
      break;
  }
  }

  set operand1(int operand1) => _operand1 = operand1;
  set operand2(int operand2) => _operand2 = operand2;
  set operator(int operator) => _operator = operator;

  int get operand1 => _operand1;
  int get operand2 => _operand2;
  int get operator => _operator;
  int get answerInt => _answer.toInt();
  double get answerDouble => _answer;
  int get score => _score;

  String getEquation() {
    String op;
    switch (_operator) {
      case 0: // addition
        op = '+';
        break;
      case 1: // subtraction
        op = '-';
        break;
      case 2: // multiplication
        op = '×';
        break;
      case 3: // division
        op = '÷';
        break;
    }
    return "$_operand1 " + op + " $_operand2";
  }
}