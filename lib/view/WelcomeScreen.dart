import 'package:flutter/material.dart';
import 'package:goldfolks/view/Account/EmailVerificationScreen.dart';
import 'package:goldfolks/view/Account/LoginScreen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Welcome to GoldFolks Application",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "The best app for elderly assistance",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
                      child: Text('Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, EmailVerificationScreen.id);
                    }),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
                      child: Text('Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
