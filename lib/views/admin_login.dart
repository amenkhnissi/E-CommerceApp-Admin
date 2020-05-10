import 'package:admin_panel/views/Widget/loading.dart';
import 'package:flutter/material.dart';
import './Widget/FadeAnimation.dart';
import 'package:admin_panel/database/authentication.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 280,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          height: 300,
                          width: width,
                          child: FadeAnimation(
                              1,
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/bg2.png'),
                                        fit: BoxFit.fill)),
                              )),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FadeAnimation(
                                1.5,
                                Text(
                                  "Admin Panel",
                                  style: TextStyle(
                                      color: Color.fromRGBO(49, 39, 79, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                            1.7,
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(196, 135, 198, .3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10),
                                    )
                                  ]),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Email",
                                            icon: Icon(Icons.email),
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: validateEmail,
                                          onChanged: (val) {
                                            setState(() => email = val);
                                          }),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Password",
                                            icon: Icon(Icons.lock_outline),
                                            hintStyle:
                                                TextStyle(color: Colors.grey)),
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validator: validatePassword,
                                        obscureText: true,
                                        onChanged: (val) {
                                          setState(() => password = val);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 10.0,
                        ),
                        FadeAnimation(
                            1.7,
                            Center(
                                child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: Color.fromRGBO(196, 135, 198, 1)),
                            ))),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        FadeAnimation(
                            1.9,
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 60),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromRGBO(49, 39, 79, 1),
                              ),
                              child: Center(
                                child: RaisedButton(
                                  color: Color.fromRGBO(49, 39, 79, 1),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      dynamic result = await _auth
                                          .signInWithEmailAndPassword(
                                              email, password);
                                      var user = result.uid;

                                     

                                     
                                      print(user);
                                      if (result == null) {
                                        setState(() {
                                          loading = false;
                                          error =
                                              'Could not sign in with those credentials';
                                        });
                                      } else {
                                        Navigator.pushReplacementNamed(
                                            context, 'dashboard');
                                      }
                                    }
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}

// Email Validator
String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}

// Name validator

String validatePassword(String value) {
  if (value.length < 8 || value.isEmpty)
    return 'Password error';
  else
    return null;
}
