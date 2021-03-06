import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goldfolks/controller/DatabaseController.dart';
import 'package:goldfolks/controller/NotificationController.dart';
import 'package:goldfolks/controller/ScreenController.dart';
import 'package:goldfolks/controller/UserAccountController.dart';
import 'package:goldfolks/model/Reminder.dart';
import 'package:goldfolks/model/UserAccount.dart';
import 'package:goldfolks/view/Account/EmailVerificationScreen.dart';
import 'package:goldfolks/view/ExerciseVideo/ExerciseScreen.dart';
import 'package:goldfolks/view/Account/ForgotPasswordScreen.dart';
import 'package:goldfolks/view/GameScreen.dart';
import 'package:goldfolks/view/HomeScreen.dart';
import 'package:goldfolks/view/MentalMathGame/MentalMathLeaderboardScreen.dart';
import 'package:goldfolks/view/Account/LoginScreen.dart';
import 'package:goldfolks/view/MentalMathGame/MentalMathGameScreen.dart';
import 'package:goldfolks/view/MentalMathGame/MentalMathMenuScreen.dart';
import 'package:goldfolks/view/MentalMathGame/MentalMathTutorialScreen.dart';
import 'package:goldfolks/view/Reminder/AddReminderScreen.dart';
import 'package:goldfolks/view/Reminder/EditReminderScreen.dart';
import 'package:goldfolks/view/Reminder/ReminderScreen.dart';
import 'package:goldfolks/view/Account/SignUpScreen.dart';
import 'package:goldfolks/view/SimonSaysGame/SimonSaysGameScreen.dart';
import 'package:goldfolks/view/SimonSaysGame/SimonSaysLeaderboardScreen.dart';
import 'package:goldfolks/view/SimonSaysGame/SimonSaysMenuScreen.dart';
import 'package:goldfolks/view/SimonSaysGame/SimonSaysTutorialScreen.dart';
import 'package:goldfolks/view/ExerciseVideo/VideoPlayerScreen.dart';
import 'package:goldfolks/view/WelcomeScreen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize firebase
  await Firebase.initializeApp();
  // initialize notification channel
  AwesomeNotifications().initialize(
    'resource://drawable/notification_bell',
    [
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        defaultColor: Colors.teal,
        locked: true,
        importance: NotificationImportance.High,
        soundSource: 'resource://raw/res_custom_notification',
      ),
    ],
  );
  // lock rotation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(new GoldFolksApp());
  });
}

class GoldFolksApp extends StatelessWidget {
  // This widget is the root of your application.
  // TODO: connect to login screen on startup (only for the first time)

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserAccount>.value(
      value: DatabaseController().user,
      initialData: UserAccountController.userDetails,
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

            // game screens
            GameScreen.id: (context) => GameScreen(),

            // Mental Math game
            MentalMathMenuScreen.id: (context) => MentalMathMenuScreen(),
            MentalMathGameScreen.id: (context) => MentalMathGameScreen(),
            MentalMathTutorialScreen.id: (context) =>
                MentalMathTutorialScreen(),
            MentalMathLeaderboardScreen.id: (context) =>
                MentalMathLeaderboardScreen(),

            // Simon Says game
            SimonSaysMenuScreen.id: (context) => SimonSaysMenuScreen(),
            SimonSaysGameScreen.id: (context) => SimonSaysGameScreen(),
            SimonSaysTutorialScreen.id: (context) => SimonSaysTutorialScreen(),
            SimonSaysLeaderboardScreen.id: (context) =>
                SimonSaysLeaderboardScreen(),

            // Exercise Video screen
            ExerciseScreen.id: (context) => ExerciseScreen(),
            VideoPlayerScreen.id: (context) => VideoPlayerScreen(),

            // Reminder screen
            ReminderScreen.id: (context) => ReminderScreen(),
            //EditReminderScreen.id: (context) => EditReminderScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == AddReminderScreen.id) {
              return PageRouteBuilder(
                settings: settings,
                pageBuilder: (context, animation, secondaryAnimation) =>
                    AddReminderScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));

                  return SlideTransition(
                    position: animation.drive(tween),
                    child: child,
                  );
                },
              );
            } else if (settings.name == EditReminderScreen.id) {
              Reminder reminder = settings.arguments;
              return MaterialPageRoute(
                  builder: (_) => EditReminderScreen(
                        reminder: reminder,
                      ));
            }
            //          else if (settings.name == EditReminderScreen.id) {
            //   return PageRouteBuilder(
            //     settings: settings,
            //     pageBuilder: (context, animation, secondaryAnimation) =>
            //         EditReminderScreen(),
            //     transitionsBuilder:
            //         (context, animation, secondaryAnimation, child) {
            //       const begin = Offset(0.0, 1.0);
            //       const end = Offset.zero;
            //       const curve = Curves.ease;
            //
            //       var tween = Tween(begin: begin, end: end)
            //           .chain(CurveTween(curve: curve));
            //
            //       return SlideTransition(
            //         position: animation.drive(tween),
            //         child: child,
            //       );
            //     },
            //   );
            // }
          }),
    );
  }
}
