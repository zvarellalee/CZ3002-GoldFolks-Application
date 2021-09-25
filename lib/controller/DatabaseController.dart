import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerNewUser(String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password); // authresult changed to usercredential
      User user = result.user;

      // create a new document for the user with uid
      await updateUserName(name, result.user);
      await updateUserData(name, email,0,0);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
    }
  }

  Future updateUserData(String name, String email, int simonSaysScore, int mentalMathScore) async {
    return await userCollection.doc(name).set({
      'Name': name,
      'Email': email,
      'SimonSaysScore': simonSaysScore,
      'MentalMathScore': mentalMathScore,
      'Reminders': [],
    });
  }

  Future updateUserName(String name, User currentUser) async {
    await currentUser.updateDisplayName(name);
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
}
