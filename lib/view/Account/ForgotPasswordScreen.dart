import 'package:email_validator/email_validator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:goldfolks/controller/DatabaseController.dart';
import 'package:goldfolks/view/Account/LoginScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String id = "ForgotPasswordScreen";
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final DatabaseController _auth = DatabaseController();
  String email = ' ';

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Container(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Forgot Password?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 8, 35, 0),
                      child: Text(
                        'Please enter your registered email address so that we can send over a password for reset',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    //spacing,
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                                decoration: InputDecoration(
                                  icon: Icon(
                                    Icons.email_sharp,
                                  ),
                                  labelText: 'Email',
                                ),
                                validator: (val) => val.isNotEmpty
                                    ? !EmailValidator.validate(val, true)
                                        ? 'Invalid email format.'
                                        : null
                                    : 'Enter email',
                                onChanged: (val) {
                                  setState(() => email = val);
                                }),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          final bool emailCheck =
                              await _auth.emailAuthentication(email);
                          if (!emailCheck) {
                            Flushbar(
                              flushbarPosition: FlushbarPosition.TOP,
                              flushbarStyle: FlushbarStyle.FLOATING,
                              backgroundColor: Color(0xffe25757),
                              margin: EdgeInsets.all(8),
                              borderRadius: 8,
                              icon: Icon(
                                Icons.warning_amber_rounded,
                                size: 35.0,
                                color: Colors.black,
                              ),
                              leftBarIndicatorColor: Colors.black,
                              messageText: Text(
                                  "Email does not exist in the system!\nTry a different email",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  )),
                              duration: Duration(seconds: 3),
                            )..show(context);
                          } else {
                            Flushbar(
                              flushbarPosition: FlushbarPosition.TOP,
                              flushbarStyle: FlushbarStyle.FLOATING,
                              backgroundColor: Color(0xffaae257),
                              margin: EdgeInsets.all(8),
                              borderRadius: 8,
                              icon: Icon(
                                Icons.notifications,
                                size: 35.0,
                                color: Colors.black,
                              ),
                              leftBarIndicatorColor: Colors.black,
                              messageText: Text(
                                  "Sent reset password link\nCheck your email",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  )),
                              duration: Duration(seconds: 3),
                            )..show(context);
                            _auth.resetPassword(email);
                            Navigator.pushNamed(context, LoginScreen.id);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
