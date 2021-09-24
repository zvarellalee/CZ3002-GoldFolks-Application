import 'package:flutter/material.dart';
import 'package:goldfolks/view/MentalMathTutorialScreen.dart';

class MentalMathMenuScreen extends StatelessWidget {
  static String id = "MentalMathMenuScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: Colors.grey,
        elevation: 0,
    ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                    "Mental Math",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      letterSpacing: 6,
                      color: Colors.black,
                    ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                style:
                ElevatedButton.styleFrom(primary: Colors.blue),
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
                    child: Text('Play',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style:
                  ElevatedButton.styleFrom(primary: Colors.white10),
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
                    child: Text('Tutorial',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, MentalMathTutorialScreen.id),
                ),
                ElevatedButton(
                  style:
                  ElevatedButton.styleFrom(primary: Colors.blue),
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
                    child: Text('Leaderboard',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                    ),
                  ),
                ),
              //onPressed:
              ]
            ),
          ),
        ),
      ),
    );
  }
}
