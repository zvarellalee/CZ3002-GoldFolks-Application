class Reminder {
  String _medicineName;
  DateTime _endDate;
  int _frequency;
  List<DateTime> _frequencyTiming;
  String _description;

  Reminder({
    String medicineName,
    DateTime endDate,
    int frequency,
    List<DateTime> frequencyTiming,
    String description,
  })  : _medicineName = medicineName,
        _endDate = endDate,
        _frequency = frequency,
        _frequencyTiming = frequencyTiming,
        _description = description;

  String get medicineName => _medicineName;
  DateTime get endDate => _endDate;
  int get frequency => _frequency;
  List<DateTime> get frequencyTiming => _frequencyTiming;
  String get description => _description;

  set medicineName(String medicineName) {
    _medicineName = medicineName;
  }

  set endDate(DateTime endDate) {
    _endDate = endDate;
  }

  set frequency(int frequency) {
    _frequency = frequency;
  }

  set frequencyTiming(List<DateTime> frequencyTiming) {
    _frequencyTiming = frequencyTiming;
  }

  set description(String description) {
    _description = description;
  }
}
