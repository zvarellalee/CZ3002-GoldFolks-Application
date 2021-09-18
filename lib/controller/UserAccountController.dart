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
    await for (var snapshot in userCollection.snapshots()) {
      List<Reminder> Reminders = [];
      var Documents = snapshot.docs;
      for (var document in Documents) {
        if (document.id == name) {
          try {
            for (var reminders in document['Reminders']) {
              Reminders.add(reminders);
            }
            userDetails.name = name;
            userDetails.email = document['Email'];
            userDetails.SimonSaysScore = document['SimonSaysScore'];
            userDetails.MentalMathScore = document['MentalMathScore'];
            userDetails.Reminders = Reminders;
          } catch (e) {
            print(e);
          }
          break;
        }
      }
      break;
    }
  }
}
