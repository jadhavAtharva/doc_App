import 'package:docapp/SplashScreen.dart';
import 'package:docapp/mainPage.dart';
import 'package:docapp/update.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'components/rounded_button.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginPage extends StatefulWidget {

  static const String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  createAlertDialogue (BuildContext context) {
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(
          'Error',
          style: TextStyle(
            fontFamily: 'Source Sans pro',
            color: Colors.red,
            fontSize: 20.0,
          ),
        ),
        content: Text(
          'Invalid Usernane and password!! \n Please try again.',
          style: TextStyle(
            fontFamily: 'Source Sans pro',
          ),
        ),
        actions: <Widget>[
          MaterialButton(
            color: Colors.red,
            elevation: 5.0,
              child: Text(
                'Try Again!',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
              Navigator.pop(context);
              }
          ),
        ],
      );
    });
  }

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String _username = '';
  String _pass = '';
   final passTextController = TextEditingController();
  final emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return MaterialApp(
      home: Container(
        height: data.size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/half1.png"),
                fit: BoxFit.cover
            ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.only(top:100.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Text(
                        'AidWise',
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 50.0,
                          color: Hexcolor('#224D4D'),
                        ),
                      ),
                    ),
                    Center(
                      child: Image(
                        image: AssetImage('images/hospital1.png'),
                        height: 250.0,
                        width: 250.0,
                      ),
                    ),
                    SizedBox(
                      height: 35.0,
                    ),
                    Center(
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          fontFamily: 'Source Sans pro',
                          fontSize: 40.0,
                          color: Hexcolor('#224D4D'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 62.5, left: 20.0, right: 20.0),
                      child: TextField(
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: emailTextController,
                        textAlign: TextAlign.center,
                        onChanged: (value){
                          _username = value;
                        },
                        decoration: kLoginTextFieldDecoration.copyWith(
                            hintText: 'Enter Email',
                            fillColor: Hexcolor('#E4EFEF'),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Hexcolor("#224D4D")),
                                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Hexcolor("#224D4d"), width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextField(
                        onTap: () {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        obscureText: true,
                        controller: passTextController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        onChanged: (value){
                          _pass = value;
                        },
                        decoration: kLoginTextFieldDecoration.copyWith(
                            hintText: 'Enter Password',
                            fillColor: Hexcolor('#E4EFEF'),
                            enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Hexcolor("#224D4D")),
                                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Hexcolor("#224D4d"), width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RoundedButton(
                        color: Hexcolor('#224D4D'),
                        title: 'LOGIN',
                        onPressed: () async{
                          passTextController.clear();
                          emailTextController.clear();
                          setState(() {
                            showSpinner = true;
                          });
                          try{
                            final user = await _auth.signInWithEmailAndPassword(email: _username, password: _pass);
                            if(user != null){
                              Navigator.pushNamed(context, MainPage.id);
                              Navigator.pushNamed(context, SplashScreen.id);
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          } catch(e) {
                            createAlertDialogue(context);
                            setState(() {
                              showSpinner = false;
                            });
                            print(e);
                          }
                        },
                        minWidth: 300.0,
                      elevation: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}