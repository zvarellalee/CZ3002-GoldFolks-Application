import 'package:flutter/material.dart';
import 'package:goldfolks/controller/DatabaseController.dart';
import 'package:goldfolks/view/HomeScreen.dart';
import 'package:goldfolks/view/Account/LoginScreen.dart';

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
          title: Text("Create Account"),
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            child: Stack(children: [
              SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: SizedBox(
                                height: 230,
                                child: Image.asset(
                                  'images/signup.png',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Enter your details and create your account!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
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
                                  ? val.length < 8
                                      ? 'Enter a password with 8+ characters'
                                      : null
                                  : 'Enter a password',
                              obscureText: _obscureText,
                              onChanged: (val) {
                                setState(() => password = val);
                              }),
                          SizedBox(height: 30.0),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(50.0, 10, 50, 10),
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
                        ],
                      )),
                ),
              ),
              showSpinner
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Colors.blueAccent),
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
