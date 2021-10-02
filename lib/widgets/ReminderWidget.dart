import 'package:flutter/material.dart';
import 'package:goldfolks/model/MedicationIcons.dart';
import 'package:goldfolks/model/MedicineType.dart';

class ReminderWidget extends StatefulWidget {
  final String medicineName;
  final MedicineType medicineType;
  final List<TimeOfDay> timingList;
  @override
  _ReminderWidgetState createState() => _ReminderWidgetState();
  
  ReminderWidget(this.medicineName, this.medicineType, this.timingList);
}

class _ReminderWidgetState extends State<ReminderWidget> {
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
        size: 40,
      );
  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(10),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                icon(),
                Text(widget.medicineName),
                Text(widget.timingList[0].toString()),
              ]
            ),
          ),
          onTap: () => print("tapped"),
        ),
      ),
    );
  }
}
