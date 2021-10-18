import 'package:flutter/material.dart';
import 'package:goldfolks/controller/DatabaseController.dart';
import 'package:goldfolks/controller/NotificationController.dart';
import 'package:goldfolks/controller/ScreenController.dart';
import 'package:goldfolks/controller/UserAccountController.dart';
import 'package:goldfolks/view/ExerciseVideo/ExerciseScreen.dart';
import 'package:goldfolks/view/GameScreen.dart';
import 'package:goldfolks/view/Reminder/ReminderScreen.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseController _auth = DatabaseController();

  @override
  void initState() {
    // TODO: implement initState
    NotificationController.tryListen();
    super.initState();
  }

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
                    Text(
                      "Welcome, ${UserAccountController.userDetails.name}",
                      textScaleFactor: 1.6,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "What would you like to do today?",
                      textScaleFactor: 1.2,
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
                      logoutButton(context, _auth),
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
            backgroundColor: MaterialStateProperty.all<Color>(
                Colors.redAccent.withOpacity(0.95)),
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

Widget logoutButton(BuildContext context, DatabaseController auth) {
  return Padding(
    padding: const EdgeInsets.all(9.0),
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(5),
          primary: Colors.black.withOpacity(0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
            Text('Log Out',
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
        onPressed: () async {
          await NotificationController
              .cancelAllNotifications(); // cancel all notifications on log out.
          await auth.signOut();
          Navigator.popUntil(context, ModalRoute.withName(ScreenController.id));
        }),
  );
}
