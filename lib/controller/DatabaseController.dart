import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:goldfolks/controller/UserAccountController.dart';
import 'package:goldfolks/model/Reminder.dart';
import 'package:goldfolks/model/UserAccount.dart';

class DatabaseController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  //create user object based on firebase user
  UserAccount _userFromFirebaseUser(User user) {
    if (user != null) {
      return UserAccount(uid: user.uid);
    } else {
      return null;
    }
  }

// auth change user stream
  Stream<UserAccount> get user {
    return _auth.authStateChanges().map((User user) => _userFromFirebaseUser(
        user)); // mapping the firebase user to the actual user
  }

  Future<bool> emailAuthentication(String email) async {
    await for (var snapshot in userCollection.snapshots()) {
      var documents = snapshot.docs;
      for (var document in documents) {
        if (document['Email'] == email) {
          return true;
        }
      }
      return false;
    }
  }

  // Sign in with email and password
  Future signInEmailandPass(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await UserAccountController.populateUser();
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// ------- for users ---------
  // register with email and password
  Future registerNewUser(String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password); // authresult changed to usercredential
      User user = result.user;

      // create a new document for the user with uid
      await updateUserName(email, result.user);
      DatabaseController DB = DatabaseController();
      await DB.updateUserData(name, email, 0, 0, []);
      await UserAccountController.populateUser();
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
    }
  }

  Future updateUserData(String name, String email, int simonSaysScore,
      int mentalMathScore, List<Reminder> reminderList) async {
    await userCollection.doc(email).set({
      'Name': name,
      'Email': email,
      'SimonSaysScore': simonSaysScore,
      'MentalMathScore': mentalMathScore,
      //'Reminders': reminderList,
    });

    for (Reminder r in reminderList) {
      await userCollection
          .doc(email)
          .collection('Reminders')
          .doc(r.reminderId.toString())
          .set(r.toJson());
    }
  }

  Future updateUserDataMap(
      String email, Map<String, dynamic> parameterMap) async {
    return await userCollection.doc(email).update(parameterMap);
  }

  Future updateUserName(String email, User currentUser) async {
    await currentUser.updateDisplayName(email);
    await currentUser.reload();
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth
          .signOut(); // this signOut calling is calling a function signOut that is actually inbuilt(not the function we just made)
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getCurrentUser() async {
    // ignore: await_only_futures
    return await _auth.currentUser;
  }

  Future<String> getCurrentUserName() async {
    // ignore: await_only_futures
    if (_auth.currentUser == null)
      return null;
    else
      return _auth.currentUser.displayName;
  }

  //------ Reminders ---------
  /// Function for retrieving the reminder list of a given user.
  Future<List<Reminder>> getReminders(String email) async {
    var querySnapshot =
        await userCollection.doc(email).collection('Reminders').get();
    List<Reminder> reminderList = [];
    for (var document in querySnapshot.docs) {
      try {
        Reminder r = Reminder.fromJson(document.data());
        reminderList.add(r);
      } catch (e) {
        print(e);
      }
    }
    return reminderList;
  }

  /// Function for adding a single new reminder
  Future addReminder(String email, Reminder reminder) async {
    return await userCollection
        .doc(email)
        .collection('Reminders')
        .doc(reminder.reminderId.toString())
        .set(reminder.toJson());
  }

  /// Function for updating selected reminder
  Future updateReminder(String email, Reminder reminder) async {
    await userCollection.doc(email).collection('Reminders')
        .doc(reminder.reminderId.toString())
        .update(reminder.toJson());
  }

  /// Function for adding a list of reminders
  Future addReminderList(String email, List<Reminder> reminderList) async {
    for (Reminder reminder in reminderList)
      await userCollection
          .doc(email)
          .collection('Reminders')
          .doc(reminder.reminderId.toString())
          .set(reminder.toJson());
  }

  /// Function for deleting a reminder
  Future deleteReminder(String email, Reminder reminder) async {
    return await userCollection
        .doc(email)
        .collection('Reminders')
        .doc(reminder.reminderId.toString())
        .delete();
  }
}
