import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goldfolks/controller/UserAccountController.dart';
import 'package:goldfolks/model/MedicineType.dart';
import 'package:goldfolks/model/Reminder.dart';
import 'package:goldfolks/widgets/ReminderWidget.dart';

import 'AddReminderScreen.dart';

class ReminderScreen extends StatefulWidget {
  static String id = "ReminderScreen";

  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text("Medication Reminders"),
        backgroundColor: Color(0xFF3EB16F),
      ),
      body: Container(
        color: Colors.black12,
        width: double.infinity,
        height: double.infinity,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Users').doc(UserAccountController.userDetails.name).collection('Reminders').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return new Text('Loading...');
              return new ListView(
                padding: EdgeInsets.all(10),
                shrinkWrap: true,
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  return new ReminderWidget(
                      document['medicineName'],
                      StringToEnum.toEnum(document['medicineType']),
                      new List<String>.from(document['frequencyTiming']).map((e) => Reminder.stringToTimeOfDay(e)).toList(),
                  );
                }).toList(),
              );
            },
          ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1, // TODO: flat or shadow?
        backgroundColor: Color(0xFF3EB16F),
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, AddReminderScreen.id), // TODO: navigate to reminder add screen
      ),
    );
  }
}
