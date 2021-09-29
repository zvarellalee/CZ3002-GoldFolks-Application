import 'package:flutter/material.dart';

class ReminderWidget extends StatefulWidget {
  final String text;
  @override
  _ReminderWidgetState createState() => _ReminderWidgetState();
  
  ReminderWidget(this.text);
}

class _ReminderWidgetState extends State<ReminderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () {  },
        child: Column(
          children: [
            Text(widget.text),
          ],
        )
      )
    );
  }
}
