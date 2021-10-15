import 'package:flutter/material.dart';
import 'package:goldfolks/controller/UserAccountController.dart';
import 'package:goldfolks/model/UserAccount.dart';
import 'package:goldfolks/view/HomeScreen.dart';
import 'package:goldfolks/view/WelcomeScreen.dart';
import 'package:provider/provider.dart';

class ScreenController extends StatelessWidget {
  static String id = 'ScreenController';

  static UserAccountController UserCntrlAccount = UserAccountController();

  static Future<bool> loadInformation(BuildContext context) async {
    await UserAccountController.populateUser();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // return either home or authenticate widget
    final user = Provider.of<UserAccount>(context);

    return FutureBuilder(
        future: loadInformation(context),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            if (user == null) {
              return WelcomeScreen();
            } else {
              return HomeScreen();
            }
          } else
            return SizedBox(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              height: 10,
              width: 10,
            );
        });
  }
}
