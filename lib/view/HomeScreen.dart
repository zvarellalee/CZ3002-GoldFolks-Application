import 'package:flutter/material.dart';
import 'package:goldfolks/controller/UserAccountController.dart';
import 'package:goldfolks/view/ExerciseScreen.dart';
import 'package:goldfolks/view/GameScreen.dart';
import 'package:goldfolks/view/ReminderScreen.dart';
import 'package:goldfolks/view/SettingsScreen.dart';

class HomeScreen extends StatelessWidget {
  static String id = 'HomeScreen';
  static String name = UserAccountController.userDetails.name;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
            body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.black12,
                constraints: BoxConstraints.expand(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // TODO: Select name from user account
                    Text(
                      "Welcome, $name",
                      textScaleFactor: 1.5,
                    ),
                    Text(
                      "What would you like to do today?",
                      textScaleFactor: 1,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RemindersButton(context),
                      GameButton(context),
                      ExerciseButton(context),
                      SettingsButton(context),
                    ],
                  )),
            ),
          ],
        )),
      ),
    );
  }
}

Widget RemindersButton(BuildContext context) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, ReminderScreen.id);
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF3EB16F)),
        ),
        child: Wrap(
          children: <Widget>[
            Icon(
              Icons.add_alert_rounded,
              color: Colors.white,
              size: 24.0,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Medication Reminders", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    ),
  );
}

Widget GameButton(BuildContext context) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, GameScreen.id);
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
        ),
        child: Wrap(
          children: <Widget>[
            Icon(
              Icons.videogame_asset,
              color: Colors.white,
              size: 24.0,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Cognitive Games", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    ),
  );
}

Widget ExerciseButton(BuildContext context) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, ExerciseScreen.id);
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
            minimumSize: MaterialStateProperty.all<Size>(
              Size(double.infinity, 30),
            )),
        child: Wrap(
          children: <Widget>[
            Icon(
              Icons.video_collection_sharp,
              color: Colors.white,
              size: 24.0,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Exercise Videos", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    ),
  );
}

Widget SettingsButton(BuildContext context) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, SettingsScreen.id);
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black26),
            minimumSize: MaterialStateProperty.all<Size>(
              Size(double.infinity, 30),
            )),
        child: Wrap(
          children: <Widget>[
            Icon(
              Icons.settings,
              color: Colors.white,
              size: 24.0,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Settings", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    ),
  );
}
