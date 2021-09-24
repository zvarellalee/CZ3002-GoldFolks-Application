import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goldfolks/controller/DatabaseController.dart';
import 'package:goldfolks/controller/ScreenController.dart';
import 'package:goldfolks/model/UserAccount.dart';
import 'package:goldfolks/view/EmailVerificationScreen.dart';
import 'package:goldfolks/view/ExerciseScreen.dart';
import 'package:goldfolks/view/ForgotPasswordScreen.dart';
import 'package:goldfolks/view/GameScreen.dart';
import 'package:goldfolks/view/HomeScreen.dart';
import 'package:goldfolks/view/LoginScreen.dart';
import 'package:goldfolks/view/MentalMathMenuScreen.dart';
import 'package:goldfolks/view/MentalMathTutorialScreen.dart';
import 'package:goldfolks/view/ReminderScreen.dart';
import 'package:goldfolks/view/SettingsScreen.dart';
import 'package:goldfolks/view/SignUpScreen.dart';
import 'package:goldfolks/view/WelcomeScreen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // TODO: connect to login screen on startup (only for the first time)
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserAccount>.value(
      value: DatabaseController().user,
      child: MaterialApp(
        title: 'GoldFolks',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: ScreenController.id,
        routes: {
          ScreenController.id: (context) => ScreenController(),
          WelcomeScreen.id: (context) => WelcomeScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          EmailVerificationScreen.id: (context) => EmailVerificationScreen(),
          ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          GameScreen.id: (context) => GameScreen(),
          MentalMathMenuScreen.id: (context) => MentalMathMenuScreen(),
          MentalMathTutorialScreen.id: (context) => MentalMathTutorialScreen(),
          ExerciseScreen.id: (context) => ExerciseScreen(),
          ReminderScreen.id: (context) => ReminderScreen(),
          SettingsScreen.id: (context) => SettingsScreen(),
        },
      ),
    );
  }
}
