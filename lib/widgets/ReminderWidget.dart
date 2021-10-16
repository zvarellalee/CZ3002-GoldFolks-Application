import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goldfolks/controller/DatabaseController.dart';
import 'package:goldfolks/controller/NotificationController.dart';
import 'package:goldfolks/controller/UserAccountController.dart';
import 'package:goldfolks/model/MedicationIcons.dart';
import 'package:goldfolks/model/MedicineType.dart';
import 'package:goldfolks/model/Reminder.dart';
import 'package:goldfolks/view/Reminder/EditReminderScreen.dart';
import 'package:intl/intl.dart';

class ReminderWidget extends StatefulWidget {
  //final String medicineName;
  //final MedicineType medicineType;
  //final String description;
  //final DateTime endDate;
  //final int frequency;
  //final List<TimeOfDay> timingList;
  //final int remainderId;
  final Reminder reminder;
  @override
  _ReminderWidgetState createState() => _ReminderWidgetState();

  ReminderWidget(
      //this.medicineName,
      // this.medicineType,
      //this.description,
      //this.endDate,
      //this.frequency,
      //this.timingList,
      //this.remainderId
      this.reminder);
}

class _ReminderWidgetState extends State<ReminderWidget> {
  DateFormat format = DateFormat('dd MMM, yyyy');
  Widget icon(double size) {
    IconData data;
    switch (widget.reminder.medicineType) {
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
    widget.reminder.frequencyTiming.forEach((e) => timings = timings +
        "${e.hour.toString().padLeft(2, '0')}:${e.minute.toString().padLeft(2, '0')}, ");
    timings = timings.substring(0, timings.length - 2);
    return Padding(
      padding: EdgeInsets.all(12),
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
                        widget.reminder.medicineName,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        timings,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: [
                          TextButton(
                            // style: TextButton.styleFrom(
                            //   primary: Colors.black45.withOpacity(0.5),
                            // ),
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFF1976D2),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, EditReminderScreen.id,
                                  arguments: widget.reminder);
                            },
                          ),
                          TextButton(
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.red,
                              ),
                            ),
                            onPressed: () {
                              showAlertDialog(context);
                            },
                          )
                        ],
                      ),
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
                    title: Text(widget.reminder.medicineName),
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
                                  widget.reminder.medicineType.string,
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
                                child: Text(widget.reminder.description),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            /*
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
                             */
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
                                itemCount:
                                    widget.reminder.frequencyTiming.length,
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
                                        "${widget.reminder.frequencyTiming[index].hour.toString().padLeft(2, '0')}:${widget.reminder.frequencyTiming[index].minute.toString().padLeft(2, '0')}",
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
                                "${format.format(widget.reminder.endDate)}",
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

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () async {
        Navigator.of(context).pop();
        DatabaseController db = DatabaseController();
        await db.deleteReminder(
            UserAccountController.userDetails.name, widget.reminder);
        await NotificationController.cancelScheduledNotifications(
            widget.reminder);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Delete Reminder"),
      content: Text("Are you sure to delete the reminder?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
