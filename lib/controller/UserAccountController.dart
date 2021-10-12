import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goldfolks/controller/DatabaseController.dart';
import 'package:goldfolks/controller/ScreenController.dart';
import 'package:goldfolks/model/Reminder.dart';
import 'package:goldfolks/model/UserAccount.dart';

class UserAccountController {
  static final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  // userDetails will be the reference we need to use when we want to access that collection

  static UserAccount userDetails = new UserAccount();
  static DatabaseController _auth = DatabaseController();

  static Future populateUser() async {
    String name = await _auth.getCurrentUserName();
    if (name != null) {
      await ScreenController.UserCntrlAccount.readUserFromDatabase(name);
    } else {
      return;
    }
  }

  Future<void> readUserFromDatabase(String name) async {
    var querySnapshot = await userCollection.get();
    var reminderSnapshot =
        await userCollection.doc(name).collection('Reminders').get();
    for (var document in querySnapshot.docs) {
      List<Reminder> Reminders = [];
      if (document.id == name) {
        try {
          if (reminderSnapshot != null) {
            for (var reminder in reminderSnapshot.docs) {
              Reminders.add(Reminder.fromJson(reminder.data()));
            }
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
        user.name = document['Name'];
        var reminderSnapshot =
            await userCollection.doc(user.name).collection('Reminders').get();
        if (reminderSnapshot != null) {
          for (var reminder in reminderSnapshot.docs) {
            Reminders.add(Reminder.fromJson(reminder.data()));
          }
        }
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
      users.sort((a, b) => b.getScore(sortBy).compareTo(a.getScore(sortBy)));
    return users;
  }
}
