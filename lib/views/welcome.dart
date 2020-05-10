import 'package:flutter/material.dart';
import 'Widget/FadeAnimation.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
          home: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg.jpg'),
                  fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
              Colors.black.withOpacity(.9),
              Colors.black.withOpacity(.4),
            ])),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "Brand New Perspective",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        '"Fashion is the armor to survive the reality of everyday life." —Bill Cunningham',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                  SizedBox(
                    height: 100,
                  ),
                  FadeAnimation(
                      1.7,
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context,'login' ),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: Center(
                              child: Text(
                                "Welcome back",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                      )),
                 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}