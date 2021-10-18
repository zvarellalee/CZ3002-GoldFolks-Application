import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:goldfolks/controller/DatabaseController.dart';
import 'package:goldfolks/view/Account/SignUpScreen.dart';

class EmailVerificationScreen extends StatefulWidget {
  static String id = "EmailVerificationScreen";
  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool enableOTP = false;
  final DatabaseController _auth = DatabaseController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyOTP = GlobalKey<FormState>();
  String email = '';
  bool showSpinner = false;
  void sendOtp() async {
    EmailAuth.sessionName = "Email verification";
    var res = await EmailAuth.sendOtp(receiverMail: _emailController.text);
    if (res) {
      print("OTP sent");
    } else {
      print("We could not send the OTP");
    }
  }

  Future<bool> verifyOTP() async {
    var res = EmailAuth.validate(
        receiverMail: _emailController.text, userOTP: _otpController.text);
    if (res) {
      print("OTP verified");
      return true;
      //Navigator.pushNamed(context, SignupScreen.id);
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: TextButton(
            child: Text(
              'Back',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[200],
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.lightGreen,
          title: Text("Create Account Page"),
          elevation: 0,
          centerTitle: true,
        ),
        body: Container(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: SizedBox(
                        height: 210,
                        child: Image.asset(
                          'images/email.png',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 8, 12, 4),
                    child: Text(
                      ' Enter your email to receive an OTP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 8, 12, 4),
                            child: TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  icon: Icon(Icons.email_sharp),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.send),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        final bool emailCheck = await _auth
                                            .emailAuthentication(email);
                                        if (emailCheck) {
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
                                                "Email exists!\nTry a different email",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    fontFamily: 'Montserrat')),
                                            duration: Duration(seconds: 3),
                                          )..show(context);
                                          setState(() => showSpinner = false);
                                          setState(() {
                                            enableOTP = false;
                                          });
                                        } else {
                                          sendOtp();
                                          setState(() {
                                            enableOTP = true;
                                          });
                                          Flushbar(
                                            flushbarPosition:
                                                FlushbarPosition.TOP,
                                            flushbarStyle:
                                                FlushbarStyle.FLOATING,
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
                                                "Sent OTP\nCheck your email",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    fontFamily: 'Montserrat')),
                                            duration: Duration(seconds: 3),
                                          )..show(context);
                                        }
                                      }
                                    },
                                  ),
                                ),
                                validator: (val) {
                                  if (!EmailValidator.validate(val, true)) {
                                    setState(() {
                                      enableOTP = false;
                                    });
                                    return 'Invalid email format';
                                  } else if (val.isEmpty)
                                    return 'Enter email';
                                  else
                                    return null;
                                },
                                onChanged: (val) {
                                  setState(() => email = val);
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 8, 12, 4),
                          child: Form(
                            key: _formKeyOTP,
                            child: TextFormField(
                              validator: (val) =>
                                  val.isEmpty ? 'Enter OTP' : null,
                              controller: _otpController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Enter OTP",
                                labelText: "OTP",
                                enabled: enableOTP,
                                icon: Icon(Icons.phonelink_ring_outlined),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.blue),
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
                            child: Text('Verify OTP',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold)),
                          ),
                          onPressed: !enableOTP
                              ? null
                              : () async {
                                  if (_formKeyOTP.currentState.validate()) {
                                    bool verifiedOTP = await verifyOTP();
                                    if (!verifiedOTP) {
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
                                            "Incorrect OTP\nPlease try again",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                fontFamily: 'Montserrat')),
                                        duration: Duration(seconds: 3),
                                      )..show(context);
                                    } else
                                      Navigator.pushNamed(
                                          context, SignUpScreen.id,
                                          arguments: email);
                                  }
                                },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
