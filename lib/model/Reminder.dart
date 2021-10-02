import 'dart:convert';

import 'package:goldfolks/model/MedicineType.dart';

class Reminder {
  int _reminderId;      // identifying id
  String _medicineName; // name of medicine
  MedicineType _medicineType; // type of medicine
  DateTime _endDate;    // end date TODO: do we need start date to?
  int _frequency;       // how many times a day TODO: do we need this? (since it is implied by num frequency timings
  List<DateTime> _frequencyTiming;  // what timings to send the reminder at (on selected days)
  List<int> _days;   // on what days to send the reminders
  String _description;  // user input description

  Reminder({
    int reminderId,
    String medicineName,
    MedicineType medicineType,
    DateTime endDate,
    int frequency,
    List<DateTime> frequencyTiming,
    List<int> days,
    String description,
  })  : _reminderId = reminderId,
        _medicineName = medicineName,
        _medicineType = medicineType,
        _endDate = endDate,
        _frequency = frequency,
        _frequencyTiming = frequencyTiming,
        _days = days,
        _description = description;

  int get reminderId => _reminderId;
  String get medicineName => _medicineName;
  MedicineType get medicineType => _medicineType;
  DateTime get endDate => _endDate;
  int get frequency => _frequency;
  List<DateTime> get frequencyTiming => _frequencyTiming;
  List<int> get days => _days;
  String get description => _description;

  set medicineName(String medicineName) => _medicineName = medicineName;
  set medicineType(MedicineType medicineType) => _medicineType = medicineType;
  set endDate(DateTime endDate) => _endDate = endDate;
  set frequency(int frequency) => _frequency = frequency;
  set frequencyTiming(List<DateTime> frequencyTiming) => _frequencyTiming = frequencyTiming;
  set days(List<int> days) => _days = days;
  set description(String description) => _description = description;

  Map<String, dynamic> toJson() => {
    "reminderId":_reminderId,
    "medicineName":_medicineName,
    "medicineType":_medicineType.string,
    "endDate":_endDate.toIso8601String(),
    "frequency":_frequency,
    "frequencyTiming":jsonEncode(_frequencyTiming.map((e) => e.toIso8601String()).toList()),
    "days":_days,
    "description":_description,
  };

  factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
    reminderId: json["reminderId"],
    medicineName: json["medicineName"],
    medicineType: json["medicineType"].medicineType,
    endDate: DateTime.parse(json["endDate"]),
    frequency: json["frequency"],
    frequencyTiming: json["frequencyTiming"].map((e) => DateTime.parse(e)).toList(),
    days: json["days"].map((e) => DateTime.parse(e)).toList(),
    description: json["description"],
  );
}
