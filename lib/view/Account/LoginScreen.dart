import 'package:email_validator/email_validator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:goldfolks/controller/DatabaseController.dart';
import 'package:goldfolks/view/Account/EmailVerificationScreen.dart';
import 'package:goldfolks/view/Account/ForgotPasswordScreen.dart';
import 'package:goldfolks/view/HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final DatabaseController _auth = DatabaseController();
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;

  //Text field state
  String email = ' ';
  String password = ' ';
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Center(
            child: Container(
              child: Stack(children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 8, 12, 4),
                        child: Text(
                          'Please login to your account!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 30.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 20.0),
                                TextFormField(
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.person),
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
                                SizedBox(height: 20.0),
                                TextFormField(
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.vpn_key),
                                      labelText: 'Password',
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                            _obscureText
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.grey[800]),
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                      ),
                                    ),
                                    obscureText: _obscureText,
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter password' : null,
                                    onChanged: (val) {
                                      setState(() => password = val);
                                    }),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: Text(
                                        'Forgot password?',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () => Navigator.pushNamed(
                                          context, ForgotPasswordScreen.id),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.blue),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          50.0, 10, 50, 10),
                                      child: Text(
                                        'Log in',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() => showSpinner = true);
                                        final bool emailCheck = await _auth
                                            .emailAuthentication(email);
                                        final result =
                                            await _auth.signInEmailandPass(
                                                email, password);
                                        if (emailCheck) {
                                          if (result != null) {
                                            Navigator.pushNamed(
                                                context, HomeScreen.id);
                                          }
                                          if (result == null) {
                                            Flushbar(
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              flushbarStyle:
                                                  FlushbarStyle.FLOATING,
                                              backgroundColor:
                                                  Color(0xffe25757),
                                              margin: EdgeInsets.all(8),
                                              borderRadius: 8,
                                              icon: Icon(
                                                Icons.warning_amber_rounded,
                                                size: 35.0,
                                                color: Colors.black,
                                              ),
                                              leftBarIndicatorColor:
                                                  Colors.black,
                                              messageText: Text(
                                                "Invalid Email and Password!\nPlease Try Again",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              duration: Duration(seconds: 3),
                                            )..show(context);
                                            setState(() {
                                              showSpinner = false;
                                            });
                                          }
                                        } else {
                                          Flushbar(
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            flushbarStyle:
                                                FlushbarStyle.FLOATING,
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
                                              "This account does not exist!\nEnter a different account or register!",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            duration: Duration(seconds: 3),
                                          )..show(context);
                                          setState(() {
                                            showSpinner = false;
                                          });
                                        }
                                      }
                                    }),
                                TextButton(
                                  child: Text("New User? Register Here",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, EmailVerificationScreen.id);
                                  },
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                showSpinner
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : SizedBox(),
              ]),
            ),
          )),
    );
  }
}
