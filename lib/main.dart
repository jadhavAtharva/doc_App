import 'package:docapp/SplashScreen.dart';
import 'package:docapp/loginPage.dart';
import 'package:docapp/mainPage.dart';
import 'package:docapp/prescription.dart';
import 'package:docapp/regPage.dart';
import 'package:docapp/speech_recognizer.dart';
import 'package:docapp/update.dart';
import 'package:flutter/material.dart';
import 'homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(DocApp());

class DocApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _DocAppState createState() => _DocAppState();
}

class _DocAppState extends State<DocApp> {

  FirebaseUser user;
  FirebaseAuth _auth = FirebaseAuth.instance;
  void pr () async{
    user = await _auth.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      initialRoute: HomePage.id,
      routes: {
        HomePage.id : (context) => HomePage(),
        MainPage.id : (context) => MainPage(),
        LoginPage.id : (context) => LoginPage(),
        RegistrationPage.id : (context) => RegistrationPage(),
        UpdatePage.id : (context) => UpdatePage(),
        PrescriptionPage.id : (context) => PrescriptionPage(),
        SplashScreen.id : (context) => SplashScreen(),
        MyApp.id : (context) => MyApp()
      },
    );
  }

  @override
  void initState() {
    super.initState();
    pr();
  }
}
