import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goldfolks/controller/DatabaseController.dart';
import 'package:goldfolks/model/Reminder.dart';
import 'package:goldfolks/model/UserAccount.dart';

class UserAccountController {
  static final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  // userDetails will be the reference we need to use when we want to access that collection

  static UserAccount userDetails = new UserAccount();
  static DatabaseController _auth = DatabaseController();

  static Future<bool> populateUser() async {
    String name = await _auth.getCurrentUserName();
    if (name == null)
      return false;
    else {
      await readUserFromDatabase(name);
    }
    return true;
  }

  static Future<void> readUserFromDatabase(String name) async {
    var querySnapshot = await userCollection.get();
    for (var document in querySnapshot.docs) {
      List<Reminder> Reminders = [];
      if (document.id == name) {
        try {
          for (var reminders in document['Reminders']) {
            Reminders.add(reminders);
          }
          userDetails.name = name;
          userDetails.email = document['Email'];
          userDetails.SimonSaysScore = document['SimonSaysScore'];
          //print(document['MentalMathScore']);
          userDetails.MentalMathScore = document['MentalMathScore'];
          userDetails.Reminders = Reminders;
        } catch (e) {
          print(e);
        }
        break;
      }
    }
  }

  static Future<List<UserAccount>> getAllUsers([String sortBy]) async {
    List<UserAccount> users = [];
    var querySnapshot = await userCollection.get();
    for (var document in querySnapshot.docs) {
      UserAccount user = new UserAccount();
      List<Reminder> Reminders = [];
      try {
        for (var reminders in document['Reminders']) {
          Reminders.add(reminders);
        }
        user.name = document['Name'];
        user.email = document['Email'];
        user.SimonSaysScore = document['SimonSaysScore'];
        user.MentalMathScore = document['MentalMathScore'];
        user.Reminders = Reminders;
      } catch (e) {
        print(e);
      }
      users.add(user);
    }
    if (sortBy != null)
      users.sort((a,b) => b.getScore(sortBy).compareTo(a.getScore(sortBy)));
    return users;
  }
}
