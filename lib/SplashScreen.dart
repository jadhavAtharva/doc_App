import 'dart:async';

import 'package:docapp/mainPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
class SplashScreen extends StatefulWidget {
  static const String id = 'splashScreen';
  
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer () async{
    var duration = Duration(seconds: 4);
    return Timer(duration, route);
  }
  route() {
    Navigator.pop(context);//pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Hexcolor('#E4EFEF'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              width: 200,
              child: Image.asset('images/hospital2.png'),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
            ),
            Text(
              'Hello Doc!',
              style: TextStyle(
                fontSize: 40.0,
                color: Hexcolor('#224D4D')
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.0),
            ),
            CircularProgressIndicator(
              backgroundColor: Hexcolor('#224D4D'),
              strokeWidth: 1,
            )
          ],
        ),
      ),
    );
  }
}
