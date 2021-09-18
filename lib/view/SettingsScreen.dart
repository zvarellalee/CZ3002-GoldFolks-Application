import 'package:flutter/material.dart';
import 'package:goldfolks/controller/DatabaseController.dart';
import 'package:goldfolks/controller/ScreenController.dart';

class SettingsScreen extends StatefulWidget {
  static String id = "SettingsScreen";
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final DatabaseController _auth = DatabaseController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
          backgroundColor: Colors.black26,
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  padding: EdgeInsets.all(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: Icon(Icons.logout),
                    ),
                    Text('Log Out',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                ),
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.popUntil(
                      context, ModalRoute.withName(ScreenController.id));
                }),
          )),
        ),
      ),
    );
  }
}
