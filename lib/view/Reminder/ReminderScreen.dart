import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goldfolks/controller/UserAccountController.dart';
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
        leading: TextButton(
          child: Text(
            'Back',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[200],
            ),
          ),
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
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(UserAccountController.userDetails.email)
                .collection('Reminders')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                );
              else {
                if (snapshot.data.docs.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No reminders saved yet',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        'Create Reminders for your medicine by clicking on the button below!',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                } else {
                  return new ListView(
                    padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return new ReminderWidget(
                          Reminder.fromJson(document.data()));
                    }).toList(),
                  );
                }
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1, // TODO: flat or shadow?
        backgroundColor: Color(0xFF3EB16F),
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context,
            AddReminderScreen.id), // TODO: navigate to reminder add screen
      ),
    );
  }
}
