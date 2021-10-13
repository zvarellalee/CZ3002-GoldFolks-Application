import 'dart:math';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:goldfolks/controller/DatabaseController.dart';
import 'package:goldfolks/controller/LocalNotificationController.dart';
import 'package:goldfolks/controller/ScreenController.dart';
import 'package:goldfolks/controller/UserAccountController.dart';
import 'package:goldfolks/model/MedicineType.dart';
import 'package:goldfolks/model/Reminder.dart';
import 'package:goldfolks/view/Reminder/ReminderScreen.dart';
import 'package:intl/intl.dart';

class AddReminderScreen extends StatefulWidget {
  static String id = "AddReminderScreen";
  @override
  _AddReminderScreenState createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _format = DateFormat("HH:mm");
  final _selectDateFormat = DateFormat("yMd");

  String _medicineName;
  String _description;
  String _frequencyString;
  int _frequency = 1;
  List<TimeOfDay> _frequencyTiming;
  //List<int> _selectedDaysList;
  DateTime _endDate;
  //List<MultiSelectItem<int>> _daysList;
  MedicineType _medicineType;

  @override
  void initState() {
    //_loadDaysList();
    super.initState();
    localNotificationManager.setOnNotificationClick(onNotificationClick);
  }

  void sendNotification(Reminder reminderInfo) async {
    await localNotificationManager.showDailyAtTimeNotification(reminderInfo);
    Navigator.pop(context);
  }

  onNotificationClick(String payload) {
    Navigator.pushNamed(context, ScreenController.id);
    Navigator.pushNamed(context, ReminderScreen.id);
  }
  /*
  _loadDaysList() {
    _daysList = [];
    _selectedDaysList = [];

    _daysList.add(MultiSelectItem(0, "Mon"));
    _daysList.add(MultiSelectItem(1, "Tue"));
    _daysList.add(MultiSelectItem(2, "Wed"));
    _daysList.add(MultiSelectItem(3, "Thu"));
    _daysList.add(MultiSelectItem(4, "Fri"));
    _daysList.add(MultiSelectItem(5, "Sat"));
    _daysList.add(MultiSelectItem(6, "Sun"));

  }
 */

  @override
  Widget build(BuildContext context) {
    _frequencyTiming = List.filled(4, TimeOfDay.now());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: false,
        backgroundColor: Colors.white, //Colors.black26,
        elevation: 0,
      ),
      body: new GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _medicationNameField(),
                SizedBox(height: 20.0),
                _medicationTypeSelector(),
                SizedBox(height: 20.0),
                _descriptionPanel(),
                SizedBox(height: 20.0),
                _schedulePanel(),
                SizedBox(height: 12.0),
                _confirmationWidget(),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _medicationNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Medication Name",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            )),
        SizedBox(height: 12.0),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter the medicine name',
          ),
          validator: (val) =>
              val.isNotEmpty ? null : 'Please enter a medicine name',
          onChanged: (val) {
            setState(() => _medicineName = val);
          },
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }

  Widget _medicationTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Medication Type",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            )),
        SizedBox(height: 12.0),
        DropdownButtonFormField(
          decoration: InputDecoration(
            //icon: Icon(Icons.medication_rounded),
            border: OutlineInputBorder(),
            hintText: "Select a medicine type",
          ),
          value: _medicineType.string,
          validator: (val) => val != null ? null : 'Select a type',
          icon: const Icon(Icons.arrow_drop_down),
          isExpanded: true,
          alignment: Alignment.center,
          iconSize: 24,
          elevation: 16,
          //style: const TextStyle(color: Colors.deepPurple),
          onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
          onChanged: (String newMedicine) {
            setState(() {
              _medicineType = newMedicine.medicineType;
            });
          },
          items: [
            MedicineType.Liquid.string,
            MedicineType.Pill.string,
            MedicineType.Syringe.string,
            MedicineType.Tablet.string,
            MedicineType.Other.string,
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _schedulePanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Schedule",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.lightGreen[100],
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Frequency",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12.0),
              _selectFrequency(),
              SizedBox(height: 12.0),
              Text(
                "At time",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12.0),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 40.0,
                  maxHeight: 60.0,
                ),
                child: _timeRowGenerator(),
              ),
              SizedBox(height: 12.0),
              /*
              Text(
                "On days",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12.0),
              Container(
                //height: 40.0,
                child: _daySelector(),
              ),
              SizedBox(height: 12.0),
               */
              Text(
                "End date",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 12.0),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 40.0,
                  maxHeight: 60.0,
                  minWidth: 120.0,
                  maxWidth: 120.0,
                ),
                child: _dateSelector(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _selectFrequency() {
    return DropdownButtonFormField(
      validator: (val) => val != null ? null : 'Select a frequency',
      decoration: InputDecoration(
          //icon: Icon(Icons.medication_rounded),
          border: OutlineInputBorder(),
          fillColor: Colors.white,
          filled: true,
          hintText: "Select a frequency"),
      value: _frequencyString,
      icon: const Icon(Icons.arrow_drop_down),
      isExpanded: true,
      alignment: Alignment.center,
      iconSize: 24,
      elevation: 16,
      //style: const TextStyle(color: Colors.deepPurple),
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      onChanged: (String freq) {
        setState(() {
          _frequencyString = freq;
          switch (_frequencyString) {
            case "Once a day":
              _frequency = 1;
              break;
            case "Twice a day":
              _frequency = 2;
              break;
            case "Three times a day":
              _frequency = 3;
              break;
            case "Four times a day":
              _frequency = 4;
              break;
          }
        });
      },
      items: [
        "Once a day",
        "Twice a day",
        "Three times a day",
        "Four times a day",
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _timeRowGenerator() {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        //shrinkWrap: true,
        itemCount: _frequency,
        separatorBuilder: (BuildContext context, int index) => SizedBox(
              width: 10,
            ),
        itemBuilder: (context, index) {
          return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              width: 120,
              child: DateTimeField(
                format: _format,
                validator: (val) => val != null ? null : 'Select time',
                resetIcon: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Time ${index + 1}",
                  contentPadding: EdgeInsets.all(10),
                ),
                textAlign: TextAlign.center,
                onShowPicker: (context, currentValue) async {
                  final TimeOfDay time = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return time == null ? null : DateTimeField.convert(time);
                },
                onChanged: (selectedTime) => _frequencyTiming[index] =
                    TimeOfDay.fromDateTime(selectedTime),
              ),
            ),
          ]);
        });
  }
  /*
  Widget _daySelector() {
    return MultiSelectChipField(
      items: _daysList,
      showHeader: false,
      height: 40,
      chipWidth: 50,
      chipShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      validator: (values) {
        if (values == null || values.isEmpty) {
          return "Select at least one day";
        }
      },
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent, width: 1.8),
      ),
      selectedChipColor: Colors.blue.withOpacity(0.5),
      selectedTextStyle: TextStyle(color: Colors.blue[800]),
      onTap: (values) {
        _selectedDaysList = values;
      },
    );
  }
   */

  Widget _dateSelector() {
    return DateTimeField(
      format: _selectDateFormat,
      validator: (val) => val != null ? null : 'Select end date',
      resetIcon: null,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
        hintText: 'End date',
        contentPadding: EdgeInsets.all(10),
      ),
      textAlign: TextAlign.center,
      onShowPicker: (context, currentValue) async {
        final date = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100));
        if (date != null) {
          return date;
        } else {
          return currentValue;
        }
      },
      onChanged: (selectedTime) => _endDate = selectedTime,
    );
  }

  Widget _descriptionPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Description",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            )),
        SizedBox(height: 12.0),
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter a description',
          ),
          keyboardType: TextInputType.multiline,
          minLines: 5, //Normal textInputField will be displayed
          maxLines: 5,
          onChanged: (val) {
            setState(() => _description = val);
          },
          textAlignVertical: TextAlignVertical.top,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }

  Widget _confirmationWidget() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.blue),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
          child: Text(
            'Add Medication Reminder',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            List<TimeOfDay> selectedFrequencies =
                _frequencyTiming.take(_frequency).toList();
            selectedFrequencies.sort((a, b) {
              int cmp = a.hour.compareTo(b.hour);
              if (cmp != 0) return cmp;
              return a.minute.compareTo(b.minute);
            });
            Reminder newReminder = new Reminder(
              reminderId: _generateNewId(),
              medicineName: _medicineName,
              medicineType: _medicineType,
              endDate: _endDate,
              frequency: _frequency,
              frequencyTiming: selectedFrequencies,
              //days: _selectedDaysList,
              description: _description,
            );
            //OfflineDatabaseController offlineDb = OfflineDatabaseController();
            //await offlineDb.createReminder(newReminder);
            String name = UserAccountController.userDetails.name;
            DatabaseController db = DatabaseController();
            await db.addReminder(name, newReminder);
            sendNotification(newReminder);
            Navigator.pop(context);
          }
        });
  }

  int _generateNewId() {
    Random rng = new Random();
    return DateTime.now().millisecondsSinceEpoch + rng.nextInt(99);
  }
}
