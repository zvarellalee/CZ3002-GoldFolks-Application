import 'package:flutter/material.dart';
import 'package:goldfolks/controller/DatabaseController.dart';
import 'package:goldfolks/view/HomeScreen.dart';
import 'package:goldfolks/view/LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'SignUpScreen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final DatabaseController _auth = DatabaseController();
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  String password = ' ';
  String name = ' ';
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          //backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: Container(
            child: Stack(children: [
              SingleChildScrollView(
                child: Center(
                  child: Container(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Text(
                              'SignUp Screen',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                                decoration: InputDecoration(
                                  icon: Icon(Icons.person),
                                  labelText: 'Name',
                                ),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter your name' : null,
                                onChanged: (val) {
                                  setState(() => name = val);
                                }),
                            SizedBox(height: 20.0),
                            TextFormField(
                              initialValue: email,
                              decoration: InputDecoration(
                                enabled: false,
                                icon: Icon(Icons.email_sharp),
                                labelText: 'Email',
                              ),
                              //readOnly: true,
                            ),
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
                                validator: (val) => val.isNotEmpty
                                    ? val.length < 6
                                        ? 'Enter a password with 6+ characters'
                                        : null
                                    : 'Enter password',
                                obscureText: _obscureText,
                                onChanged: (val) {
                                  setState(() => password = val);
                                }),
                            SizedBox(height: 30.0),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      50.0, 10, 50, 10),
                                  child: Text('Register',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() => showSpinner = true);
                                    await _auth.registerNewUser(
                                        email, password, name);
                                    Navigator.pushNamed(context, HomeScreen.id);
                                  }
                                  setState(() => showSpinner = false);
                                }),
                            TextButton(
                              child: Text(
                                "Have an account? Login Here",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, LoginScreen.id);
                              },
                            ),
                          ],
                        )),
                  ),
                ),
              ),
              showSpinner
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    )
                  : SizedBox(),
            ]),
          ),
        ),
      ),
    );
  }
}
