import 'package:flutter/material.dart';
import 'package:goldfolks/controller/UserAccountController.dart';
import 'package:goldfolks/model/UserAccount.dart';

class MentalMathLeaderboardScreen extends StatefulWidget {
  static String id = "MentalMathLeaderboardScreen";
  @override
  _MentalMathLeaderboardScreenState createState() => _MentalMathLeaderboardScreenState();
}

class _MentalMathLeaderboardScreenState extends State<MentalMathLeaderboardScreen> {
  List<UserAccount> userList;

  Widget LeaderboardWidget() {
    return FutureBuilder<List<UserAccount>>(
        future: UserAccountController.getAllUsers("MentalMathScore"),
        builder: (BuildContext context,
            AsyncSnapshot<List<UserAccount>> snapshot) {
          Widget child;
          if (snapshot.hasData) { // good to go
            child = ListView.separated(
                separatorBuilder: (BuildContext context, int index) => const Divider(
                  color: Colors.black87,
                ),
                padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    UserAccount user = snapshot.data[index];
                    return Column(
                      children: [
                        Container(
                          //width: double.infinity,
                          height: 80.0,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: (user.name == UserAccountController.userDetails.name) ? Color.fromRGBO(199, 236, 255, 100) : Colors.white,
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  20))
                          ),
                          //margin: const EdgeInsets.all(10.0),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row (
                                    children: [
                                      Text(
                                        "${index+1}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          //letterSpacing: 6,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                      SizedBox(width:20.0),
                                      Text(
                                        "${user.name}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          //letterSpacing: 6,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ]
                                  )
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "${user.MentalMathScore} points",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      //letterSpacing: 6,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
              );
          } else if (snapshot.hasError) { // error retrieving
            child = Column (
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Try again later'),
                )
              ],
            );
          } else { // loading
            child = Column (
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Please wait...'),
                )
              ],
            );
          }
          return child;
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          "Leaderboard",
          style: TextStyle(color: Colors.black87),
          ),
        backgroundColor: Colors.white,//Colors.black26,
        elevation: 0,
      ),
      body: Container(
        //padding: EdgeInsets.all(40),
        alignment: Alignment.center,
        color: Colors.white70,
        child: LeaderboardWidget(),
        ),
    );
  }
}
