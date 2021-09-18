import 'package:flutter/material.dart';
import 'package:goldfolks/controller/UserAccountController.dart';
import 'package:goldfolks/model/UserAccount.dart';
import 'package:goldfolks/view/HomeScreen.dart';
import 'package:goldfolks/view/WelcomeScreen.dart';
import 'package:provider/provider.dart';

class ScreenController extends StatelessWidget {
  static String id = 'ScreenManager';
  @override
  Widget build(BuildContext context) {
    // return either home or authenticate widget
    final user = Provider.of<UserAccount>(context);

    return FutureBuilder(
      future: UserAccountController.populateUser(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (user == null) {
          return WelcomeScreen();
        } else {
          return HomeScreen();
        }
      },
    );
  }
}
