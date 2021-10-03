import 'package:flutter/material.dart';
import 'package:goldfolks/model/MedicationIcons.dart';
import 'package:goldfolks/model/MedicineType.dart';
import 'package:intl/intl.dart';

class ReminderWidget extends StatefulWidget {
  final String medicineName;
  final MedicineType medicineType;
  final String description;
  final DateTime endDate;
  final List<int> daysList;
  final List<TimeOfDay> timingList;
  @override
  _ReminderWidgetState createState() => _ReminderWidgetState();
  
  ReminderWidget(this.medicineName, this.medicineType, this.description, this.endDate, this.daysList, this.timingList);
}

class _ReminderWidgetState extends State<ReminderWidget> {
  DateFormat format = DateFormat('dd MMM, yyyy');
  Widget icon() {
    IconData data;
    switch(widget.medicineType) {
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
        size: 50,
      );
  }

  String convertToDay(int num) {
    switch (num) {
      case 0: return "Mon";
      case 1: return "Tue";
      case 2: return "Wed";
      case 3: return "Thu";
      case 4: return "Fri";
      case 5: return "Sat";
      case 6: return "Sun";
    }
  }
  @override
  Widget build(BuildContext context) {
    String timings = "at ";
    widget.timingList.forEach(
            (e) => timings = timings + "${e.hour.toString().padLeft(2, '0')}:${e.minute.toString().padLeft(2, '0')}, "
    );
    timings = timings.substring(0, timings.length - 2);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex:2,
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
                    ]
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: icon(),
                  ),
                ),

              ]
            ),
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
                      Text(
                        widget.medicineType.string,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      SizedBox(height:10.0),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(widget.description),
                        ),
                      ),
                    SizedBox(height:10.0),
                    Text(
                        "On days:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    SizedBox(height:10.0),
                    Container(
                      height: 28.0,
                      width: 500.0,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.daysList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            //height: 40.0,
                            width: 45.0,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Padding(
                            padding: EdgeInsets.all(5.0),
                              child: Text(
                                convertToDay(widget.daysList[index]),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: 5.0);
                        },
                      ),
                    ),
                      SizedBox(height:10.0),
                      Text(
                          "At times:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      SizedBox(height:10.0),
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
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: 5.0);
                        },
                      ),
                    ),
                    SizedBox(height:10.0),
                    Text(
                        "Ends on ${format.format(widget.endDate)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    SizedBox(height:10.0),
                  ]
                ),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
            )
          ),
        ),
      ),
    );
  }
}
