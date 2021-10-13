import 'package:flutter/material.dart';
import 'package:goldfolks/model/MedicineType.dart';

class Reminder {
  int _reminderId;      // identifying id
  String _medicineName; // name of medicine
  MedicineType _medicineType; // type of medicine
  DateTime _endDate;    // end date TODO: do we need start date to?
  int _frequency;       // how many times a day TODO: do we need this? (since it is implied by num frequency timings
  List<TimeOfDay> _frequencyTiming;  // what timings to send the reminder at (on selected days)
  //List<int> _days;   // on what days to send the reminders
  String _description;  // user input description

  Reminder({
    int reminderId,
    String medicineName,
    MedicineType medicineType,
    DateTime endDate,
    int frequency,
    List<TimeOfDay> frequencyTiming,
    //List<int> days,
    String description,
  }) {
    //frequencyTiming.sort((a,b) => (a.hour + a.minute/60.0).compareTo(b.hour + b.minute/60.0));
    _reminderId = reminderId;
    _medicineName = medicineName;
    _medicineType = medicineType;
    _endDate = endDate;
    _frequency = frequency;
    _frequencyTiming = frequencyTiming;
    //_days = days;
    _description = description;
  }

  int get reminderId => _reminderId;
  String get medicineName => _medicineName;
  MedicineType get medicineType => _medicineType;
  DateTime get endDate => _endDate;
  int get frequency => _frequency;
  List<TimeOfDay> get frequencyTiming => _frequencyTiming;
  //List<int> get days => _days;
  String get description => _description;

  set reminderId(int reminderId) => _reminderId = reminderId;
  set medicineName(String medicineName) => _medicineName = medicineName;
  set medicineType(MedicineType medicineType) => _medicineType = medicineType;
  set endDate(DateTime endDate) => _endDate = endDate;
  set frequency(int frequency) => _frequency = frequency;
  set frequencyTiming(List<TimeOfDay> frequencyTiming) => _frequencyTiming = frequencyTiming;
  //set days(List<int> days) => _days = days;
  set description(String description) => _description = description;

  Map<String, dynamic> toJson() => {
    "reminderId":_reminderId,
    "medicineName":_medicineName,
    "medicineType":_medicineType.string,
    "endDate":_endDate.toIso8601String(),
    "frequency":_frequency,
    "frequencyTiming":_frequencyTiming.map((e) => _TimeOfDayToString(e)).toList(),
    //"days":_days,
    "description":_description,
  };

  static TimeOfDay stringToTimeOfDay(String s) {
    List<String> nums = s.split(":");
    return TimeOfDay(hour:int.parse(nums[0]),minute: int.parse(nums[1]));
  }
  
  static String _TimeOfDayToString(TimeOfDay t) {
    return t.hour.toString() + ":" + t.minute.toString();
  }

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      reminderId: json["reminderId"],
      medicineName: json["medicineName"],
      medicineType: StringToEnum.toEnum(json["medicineType"]),
      endDate: DateTime.parse(json["endDate"]),
      frequency: json["frequency"],
      frequencyTiming: new List<String>.from(json["frequencyTiming"]).map((String e) => stringToTimeOfDay(e)).toList(),
      //days: new List<int>.from(json["days"]),
      description: json["description"],
    );
  }
}
