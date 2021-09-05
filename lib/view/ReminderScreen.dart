import 'package:flutter/material.dart';

class ReminderScreen extends StatefulWidget {
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

      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0, // TODO: flat or shadow?
        backgroundColor: Color(0xFF3EB16F),
        child: Icon(Icons.add),
        onPressed: () {}, // TODO: navigate to reminder add screen
      ),
    );
  }
}
