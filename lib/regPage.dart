import 'package:docapp/SplashScreen.dart';
import 'package:docapp/mainPage.dart';
import 'package:flutter/material.dart';
import 'components/rounded_button.dart';
import 'constants.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationPage extends StatefulWidget {

  static const String id = 'registration_page';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final _auth = FirebaseAuth.instance;
  final _fireStore = Firestore.instance;
  final nameTextController = TextEditingController();
  final passTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  final usernameTextController = TextEditingController();
  bool showSpinner = false;
  String _name = '';
  String _username = '';
  String _pass = '';
  String _phone = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
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
                padding: const EdgeInsets.only(top: 100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        'REGISTER',
                        style: TextStyle(
                          fontFamily: 'Source Sans pro',
                          fontSize: 40.0,
                          color: Hexcolor('#224D4D'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 62.5, left: 20.0, right: 20.0),
                      child: TextField(
                        controller: nameTextController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        onChanged: (value){
                          _name = value;
                        },
                        decoration: kLoginTextFieldDecoration.copyWith(
                            hintText: 'Enter Full Name',
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
                        controller: usernameTextController,
                        keyboardType: TextInputType.emailAddress,
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
                        controller: phoneTextController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (value){
                          _phone = value;
                        },
                        decoration: kLoginTextFieldDecoration.copyWith(
                            hintText: 'Enter Phone Number',
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
                        controller: passTextController,
                        obscureText: true,
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
                      height: 120.0,
                    ),
                    RoundedButton(
                      color: Hexcolor('#224D4D'),
                      title: 'REGISTER',
                      onPressed: () async{
                        setState(() {
                          showSpinner = true;
                        });
                        nameTextController.clear();
                        passTextController.clear();
                        phoneTextController.clear();
                        usernameTextController.clear();
                        try {
                          final newUser = await _auth.createUserWithEmailAndPassword(email: _username, password: _pass);
                          if(newUser != null){
                            try{
                              _fireStore.collection('user').add({
                                'name': _name,
                                'phone_no': _phone,
                                'username': _username
                              }
                              );
                            } catch(e) {
                              print(e);
                            }
                            Navigator.pushNamed(context, MainPage.id);
                            Navigator.pushNamed(context, SplashScreen.id);
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        }catch(e) {
                          createAlertDialogue(context, 'Error', 'User Already Exists!!!');
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

  createAlertDialogue (BuildContext context, String title, String message) {
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Source Sans pro',
            color: Hexcolor('#224D4D'),
            fontSize: 20.0,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            fontFamily: 'Source Sans pro',
          ),
        ),
        actions: <Widget>[
          MaterialButton(
              color: Hexcolor('#224D4D'),
              elevation: 5.0,
              child: Text(
                'OK',
                style: TextStyle(
                  color: Hexcolor('#E4EFEF'),
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

}