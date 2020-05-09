import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:docapp/homePage.dart';
import 'package:docapp/loginPage.dart';
import 'package:docapp/prescription.dart';
import 'package:docapp/update.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'constants.dart';
import 'components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'update.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;

String docName ;
String email ;
String name ;
String url ;
String num;
var user;


class MainPage extends StatefulWidget {

  static const String id = 'main_page';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  bool isLoggedIn = false;
  final _auth = FirebaseAuth.instance;
  final _fireStore = Firestore.instance;
  FirebaseUser loggedInUser;
  bool isLogged = false ;
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    //startTimer();
    getCurrentUser();
   // docName = getName();
    getName().then((List data){
      setState(() {
        docName = data[0];
        email = data[1];
        num = data[2];
      });
    });
  }

  void getCurrentUser() async{
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    }  catch(e) {
      print(e);
    }
  }
  Future<List> getName() async{
    var docName1 = '';
    var email = '';
    final names = await _fireStore.collection('user').getDocuments();
    for (var name in names.documents) {
      if (name.data['username'] == loggedInUser.email) {
        docName1 = name.data['name'];
        email = name.data['username'];
        num = name.data['phone_no'];
      }
    }
    return [docName1, email, num];
    }

    @override
    Widget build(BuildContext context) {
    setState(() {
      getURL();
    });
      return MaterialApp(
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/back5.jpg"), fit: BoxFit.cover)),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Container(
                child: Text(
                  'Hello Dr.$docName',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
                height: 50.0,
              ),
              centerTitle: true,
            ),
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 300.0,
                    margin: EdgeInsets.zero,
                    child: DrawerHeader(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 100.0,
                            backgroundColor: Hexcolor('#E4EFEF'),
                            backgroundImage: url != null ? NetworkImage('$url') : AssetImage('images/doc1.png'),
                          ),
                          Text(
                              docName != null ? docName : 'NULL',
                            style: TextStyle(
                              color: Hexcolor('#E4EFEF'),
                              fontSize: 30.0,
                              fontFamily: 'Source Sans pro',
                            ),
                          ),
                          Text(
                            num != null ? num : 'NULL',
                            style: TextStyle(
                              color: Hexcolor('#E4EFEF'),
                              fontSize: 15.0,
                              fontFamily: 'Source Sans pro',
                            ),
                          ),
                          Text(
                              email != null ? email : 'NULL',
                            style: TextStyle(
                              color: Hexcolor('#E4EFEF'),
                              fontSize: 15.0,
                              fontFamily: 'Source Sans pro',
                            ),
                          )
                        ],
                      ),
                      margin: EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                        color: Hexcolor('#224D4D'),
                      ),
                    ),
                  ),
                  Container(
                    height: 700.0,
                    color: Hexcolor('#E4EFEF'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: Center(
                            child: Text('Update Details'),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(context, MaterialPageRoute(builder:  (context) => MainPage()));
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage()));
                          },
                        ),
                        Divider(
                          indent: 20.0,
                          endIndent: 20.0,
                          color: Hexcolor('#224D4D'),
                          thickness: 1.25,
                        ),
                        ListTile(
                          title: Center(child: Text('About Doctor')),
                          onTap: () {
                          },
                        ),
                        Divider(
                          indent: 20.0,
                          endIndent: 20.0,
                          color: Hexcolor('#224D4D'),
                          thickness: 1.25,
                        ),
                        ListTile(
                          title: Center(child: Text('About Us')),
                          onTap: () {
                          },
                        ),
                        Divider(
                          indent: 20.0,
                          endIndent: 20.0,
                          color: Hexcolor('#224D4D'),
                          thickness: 1.25,
                        ),
                        ListTile(
                          title: Center(child: Text('Logout')),
                          onTap: ()  async{
                            await _auth.signOut();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                          },
                        ),
                        Divider(
                          indent: 20.0,
                          endIndent: 20.0,
                          color: Hexcolor('#224D4D'),
                          thickness: 1.25,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            resizeToAvoidBottomPadding: true,
            body: WillPopScope(
              onWillPop: () async => false,
              child: ModalProgressHUD(
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
                              child: CircleAvatar(
                                backgroundImage: url != null ? NetworkImage(url) : AssetImage('images/doc1.png'),
                                backgroundColor: Colors.transparent,
                                radius: 100.0,
                              )
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextField(
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {},
                                  decoration: kTextFieldDecoration.copyWith(
                                      hintText: 'Enter Patient ID')
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextField(
                                  textCapitalization: TextCapitalization.sentences,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {},
                                  decoration: kTextFieldDecoration.copyWith(
                                      hintText: 'Enter Patient Name')
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            RoundedButton(
                              title: 'Start Prescription',
                              color: Hexcolor('#224D4D'),
                              minWidth: 300.0,
                              onPressed: () async{
                                setState(() {
                                  showSpinner = true;
                                });
                                var body = await http.post('http://192.168.56.1:5000/hello');
                                showSpinner = false;
                                Navigator.push(context, MaterialPageRoute(builder:(context) => PrescriptionPage(data: body.body)));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
              ),
            )
          ),
        ),
      );
    }

  Future getURL() async {
    if (email != null) {
      String urlName = email + '.jpg';
      url = await loadImage(context, urlName);
      print(urlName);
    }
  }

  void startTimer() {
    Timer(Duration(seconds: 10000), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  void navigateUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    print(status);
    if (status) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MainPage()));
    }
  }
  }
