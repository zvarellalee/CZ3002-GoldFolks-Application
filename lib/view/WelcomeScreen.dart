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
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Center(
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('images/GoldFolks logo.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Welcome to GoldFolks Application!",
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
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreen,
                      fixedSize: const Size(200, 50)),
                  child: Text('Create Account',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.pushNamed(context, EmailVerificationScreen.id);
                  }),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "or",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreen,
                      fixedSize: const Size(200, 50)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
    );
  }
}
