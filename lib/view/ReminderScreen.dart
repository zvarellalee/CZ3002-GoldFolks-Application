import 'package:flutter/material.dart';
import 'package:goldfolks/widgets/ReminderWidget.dart';

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
        title: Text("Medication Reminders"),
        backgroundColor: Color(0xFF3EB16F),
      ),
      body: Container(
          // TODO: ListView builder
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReminderWidget("Reminder 1"),
              ReminderWidget("Reminder 2"),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        elevation: 1, // TODO: flat or shadow?
        backgroundColor: Color(0xFF3EB16F),
        child: Icon(Icons.add),
        onPressed: () {}, // TODO: navigate to reminder add screen
      ),
    );
  }
}
