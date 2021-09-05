import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
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
                    child: Column (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // TODO: Select name from user account
                        Text(
                          "Welcome, John!",
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
                      child: Column (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RemindersButton(context),
                          GameButton(context),
                          ExerciseButton(context),
                          SettingsButton(context),
                        ],
                      )
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

}

Widget RemindersButton(BuildContext context) {
  return Expanded(
    child: Padding (
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed:() {
          print("Pressed Medication");
          Navigator.pushNamed(context, '/reminder');
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder> (
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color> (
              Color(0xFF3EB16F)),
        ),
        child: Wrap(
          children: <Widget>[
            Text("Medication Reminders", style:TextStyle(fontSize:20)),
            SizedBox(
              width:10,
            ),
            Icon(
              Icons.add_alert_rounded,
              color: Colors.white,
              size: 24.0,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget GameButton(BuildContext context) {
  return Expanded(
    child: Padding (
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed:() {
          print("Pressed Game");
          Navigator.pushNamed(context, '/game');
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder> (
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color> (
              Colors.blueAccent),
        ),
        child: Wrap(
          children: <Widget>[
            Text("Cognitive Games", style:TextStyle(fontSize:20)),
            SizedBox(
              width:10,
            ),
            Icon(
              Icons.videogame_asset,
              color: Colors.white,
              size: 24.0,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget ExerciseButton(BuildContext context) {
  return Expanded (
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed:() {
          print("Pressed Exercise");
          Navigator.pushNamed(context, '/exercise');
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder> (
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color> (
                Colors.redAccent),
            fixedSize: MaterialStateProperty.all<Size> (
              Size(double.infinity, 30),
            )
        ),
        child: Wrap(
          children: <Widget>[
            Text("Exercise Videos", style:TextStyle(fontSize:20)),
            SizedBox(
              width:10,
            ),
            Icon(
              Icons.volunteer_activism,
              color: Colors.white,
              size: 24.0,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget SettingsButton(BuildContext context) {
  return Expanded (
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed:() {
          print("Pressed Settings");
          Navigator.pushNamed(context, '/settings');
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder> (
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color> (
                Colors.black26),
            fixedSize: MaterialStateProperty.all<Size> (
              Size(double.infinity, 30),
            )
        ),
        child: Wrap(
          children: <Widget>[
            Text("Settings", style:TextStyle(fontSize:20)),
            SizedBox(
              width:10,
            ),
            Icon(
              Icons.settings,
              color: Colors.white,
              size: 24.0,
            ),
          ],
        ),
      ),
    ),
  );
}