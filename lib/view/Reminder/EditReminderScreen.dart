import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:goldfolks/controller/DatabaseController.dart';
import 'package:goldfolks/controller/NotificationController.dart';
import 'package:goldfolks/controller/UserAccountController.dart';
import 'package:goldfolks/model/MedicineType.dart';
import 'package:goldfolks/model/Reminder.dart';
import 'package:intl/intl.dart';

class EditReminderScreen extends StatefulWidget {
  static String id = "EditReminderScreen";
  final Reminder reminder;

  const EditReminderScreen({Key key, this.reminder}) : super(key: key);

  @override
  _EditReminderScreenState createState() => _EditReminderScreenState();
}

class _EditReminderScreenState extends State<EditReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _format = DateFormat("HH:mm");
  final _selectDateFormat = DateFormat("yMd");

  String _medicineName;
  String _description;
  String _frequencyString;
  int _frequency = 1;
  int _oldFrequency;
  List<TimeOfDay> _frequencyTiming;
  //List<int> _selectedDaysList;
  DateTime _endDate;
  //List<MultiSelectItem<int>> _daysList;
  MedicineType _medicineType;

  @override
  void initState() {
    // TODO: implement initState
    //_loadDaysList();

    //localNotificationManager.setOnNotificationClick(onNotificationClick);

    //Future.delayed(Duration.zero, () {
    //Reminder reminder = ModalRoute.of(context).settings.arguments;
    _medicineName = widget.reminder.medicineName;
    _description = widget.reminder.description;
    _frequency = widget.reminder.frequency;
    _oldFrequency = widget.reminder.frequency;
    _frequencyTiming = List.filled(4, TimeOfDay.now());
    for (int i = 0; i < widget.reminder.frequencyTiming.length; i++) {
      _frequencyTiming[i] = widget.reminder.frequencyTiming[i];
    }
    //_selectedDaysList = reminder.days;
    _endDate = widget.reminder.endDate;
    _medicineType = widget.reminder.medicineType;

    switch (_frequency) {
      case 1:
        _frequencyString = "Once a day";
        break;
      case 2:
        _frequencyString = "Twice a day";
        break;
      case 3:
        _frequencyString = "Three times a day";
        break;
      case 4:
        _frequencyString = "Four times a day";
        break;
    }
    //});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            TextButton(
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Icon(Icons.close, color: Colors.black87),
                Text('Close',
                    style: TextStyle(fontSize: 15, color: Colors.black))
              ]),
              onPressed: () => Navigator.of(context).pop(),
            ),
            SizedBox(width: 25),
          ],
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
                _medicationNameField(widget.reminder),
                SizedBox(height: 20.0),
                _medicationTypeSelector(widget.reminder),
                SizedBox(height: 20.0),
                _descriptionPanel(widget.reminder),
                SizedBox(height: 20.0),
                _schedulePanel(),
                SizedBox(height: 12.0),
                _confirmationWidget(widget.reminder),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _medicationNameField(Reminder reminder) {
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
          initialValue: reminder.medicineName,
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

  Widget _medicationTypeSelector(Reminder reminder) {
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
            //hintText: reminder.medicineType.string,
          ),
          value: _medicineType.string,
          validator: (val) => val != null ? null : 'Select a type',
          icon: const Icon(Icons.arrow_drop_down),
          isExpanded: true,
          alignment: Alignment.center,
          iconSize: 24,
          elevation: 16,
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
            color: Color(0xFF3EB16F).withOpacity(0.5),
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
    DateTime now = DateTime.now();
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
                initialValue: (_frequencyTiming[index] != null)
                    ? DateTime(
                        now.year,
                        now.month,
                        now.day,
                        _frequencyTiming[index].hour,
                        _frequencyTiming[index].minute)
                    : null,
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
      initialValue: _endDate,
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

  Widget _descriptionPanel(Reminder reminder) {
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
          initialValue: reminder.description,
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

  Widget _confirmationWidget(Reminder reminder) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.blue),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
          child: Text(
            'Edit Medication Reminder',
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
              reminderId: reminder.reminderId,
              notificationIds: reminder.notificationIds,
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
            String email = UserAccountController.userDetails.email;
            DatabaseController db = DatabaseController();
            await db.updateReminder(email, newReminder);
            await NotificationController.changeDailyNotifications(
                newReminder, _oldFrequency);
            Navigator.pop(context);
          }
        });
  }
}
