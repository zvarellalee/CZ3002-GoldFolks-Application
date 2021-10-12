import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goldfolks/model/MedicationIcons.dart';
import 'package:goldfolks/model/MedicineType.dart';
import 'package:goldfolks/model/Reminder.dart';
import 'package:goldfolks/view/Reminder/EditReminderScreen.dart';
import 'package:intl/intl.dart';

class ReminderWidget extends StatefulWidget {
  final String medicineName;
  final MedicineType medicineType;
  final String description;
  final DateTime endDate;
  final int frequency;
  final List<int> daysList;
  final List<TimeOfDay> timingList;
  final int remainderId;
  @override
  _ReminderWidgetState createState() => _ReminderWidgetState();

  ReminderWidget(
      this.medicineName,
      this.medicineType,
      this.description,
      this.endDate,
      this.frequency,
      this.daysList,
      this.timingList,
      this.remainderId);
}

class _ReminderWidgetState extends State<ReminderWidget> {
  DateFormat format = DateFormat('dd MMM, yyyy');
  Widget icon(double size) {
    IconData data;
    switch (widget.medicineType) {
      case MedicineType.Liquid:
        data = MedicationIcon.local_drink;
        break;
      case MedicineType.Pill:
        data = MedicationIcon.pills;
        break;
      case MedicineType.Syringe:
        data = MedicationIcon.syringe;
        break;
      case MedicineType.Tablet:
        data = MedicationIcon.tablets;
        break;
      case MedicineType.Other:
        data = MedicationIcon.health;
        break;
    }
    return Icon(
      data,
      color: Color(0xFF3EB16F),
      size: size,
    );
  }

  String convertToDay(int num) {
    switch (num) {
      case 0:
        return "Mon";
      case 1:
        return "Tue";
      case 2:
        return "Wed";
      case 3:
        return "Thu";
      case 4:
        return "Fri";
      case 5:
        return "Sat";
      case 6:
        return "Sun";
    }
  }

  @override
  Widget build(BuildContext context) {
    String timings = "at ";
    widget.timingList.forEach((e) => timings = timings +
        "${e.hour.toString().padLeft(2, '0')}:${e.minute.toString().padLeft(2, '0')}, ");
    timings = timings.substring(0, timings.length - 2);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(children: [
              Expanded(
                flex: 2,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.medicineName,
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        timings,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      TextButton(
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF1976D2),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, EditReminderScreen.id,
                              arguments: Reminder(
                                reminderId: widget.remainderId,
                                medicineName: widget.medicineName,
                                medicineType: widget.medicineType,
                                endDate: widget.endDate,
                                frequency: widget.frequency,
                                frequencyTiming: widget.timingList,
                                days: widget.daysList,
                                description: widget.description,
                              ));
                        },
                      )
                    ]),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: icon(50),
                ),
              ),
            ]),
          ),
          onTap: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text(widget.medicineName),
                    content: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 100.0,
                      ),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Type: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text(
                                  widget.medicineType.string,
                                ),
                                SizedBox(width: 5.0),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: icon(25),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Text("Description:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 10.0),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(widget.description),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text("On days:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 10.0),
                            Container(
                              height: 65.0,
                              //maxHeight: 65.0,
                              width: 500.0,
                              child: GridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 5,
                                shrinkWrap: true,
                                childAspectRatio: 45.0 / 25.0,
                                children: List.generate(
                                  widget.daysList
                                      .length, // Replace this with 1, 2 to see min height works.
                                  (index) => Padding(
                                    padding: EdgeInsets.all(3.0),
                                    child: Container(
                                      height: 25.0,
                                      width: 45.0,
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text(
                                          convertToDay(widget.daysList[index]),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text("At times:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 10.0),
                            Container(
                              height: 28.0,
                              width: 500.0,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.timingList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    //height: 40.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Text(
                                        "${widget.timingList[index].hour.toString().padLeft(2, '0')}:${widget.timingList[index].minute.toString().padLeft(2, '0')}",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(width: 5.0);
                                },
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Row(children: [
                              Text("Ends on: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(
                                "${format.format(widget.endDate)}",
                              ),
                            ]),
                            SizedBox(height: 10.0),
                          ]),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  )),
        ),
      ),
    );
  }

  int _generateNewId() {
    Random rng = new Random();
    return DateTime.now().millisecondsSinceEpoch + rng.nextInt(99);
  }
}
