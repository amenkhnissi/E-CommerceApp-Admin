import 'package:admin_panel/database/authentication.dart';
import 'package:admin_panel/views/admin_dashboard.dart';
import 'package:admin_panel/views/admin_login.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/welcome.dart';
import 'package:provider/provider.dart';
import 'package:admin_panel/models/admin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  StreamProvider<Admin>.value(
      value : AuthService().user,
          child: MaterialApp(
          routes: {
            'login':(context) => Login(),
            'dashboard':(context) => Dashboard(),
          },
          debugShowCheckedModeBanner: false,
          home:  WelcomePage()  ,
        ),
    );
    
  }
}

