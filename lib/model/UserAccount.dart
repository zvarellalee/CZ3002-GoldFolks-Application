import 'package:goldfolks/model/Reminder.dart';

class UserAccount {
  String uid;
  String _name;
  String _email;
  int _SimonSaysScore;
  int _MentalMathScore;
  List<Reminder> _Reminders;

  UserAccount({
    String name,
    String email,
    int SimonSaysScore,
    int MentalMathScore,
    List<Reminder> Reminders,
    String uid,
  })  : _name = name,
        _email = email,
        _SimonSaysScore = SimonSaysScore,
        _MentalMathScore = MentalMathScore,
        _Reminders = Reminders;
  //uid = this.uid;

  String get name => _name;
  String get email => _email;
  int get SimonSaysScore => _SimonSaysScore;
  int get MentalMathScore => _MentalMathScore;
  List<Reminder> get Reminders => _Reminders;

  set name(String name) {
    _name = name;
  }

  set email(String email) {
    _email = email;
  }

  set SimonSaysScore(int SimonSaysScore) {
    _SimonSaysScore = SimonSaysScore;
  }

  set MentalMathScore(int MentalMathScore) {
    _MentalMathScore = MentalMathScore;
  }

  set Reminders(List<Reminder> Reminders) {
    _Reminders = Reminders;
  }
}
