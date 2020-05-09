import 'package:docapp/loginPage.dart';
import 'package:docapp/regPage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'components/rounded_button.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {

  static const String id = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
           statusBarBrightness: Brightness.light,
          statusBarColor: Hexcolor('#224D4D'),
        ),
    );
    final data = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          color: Hexcolor("#E4EFEF"),
          height: data.size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  'Hello Doc!',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    color: Hexcolor('#224D4D'),
                    fontSize: 50.0,
                  ),
                ),
                height: 100.0,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 7.5, top: 30.0),
                child: Image(
                    image: AssetImage('images/allDoc.jpg'),
                    height: 450.0,
                ),
              ),
              RoundedButton(
                color: Hexcolor('#E4EFEF'),
                title: 'LOGIN',
                onPressed: () {
                  Navigator.pushNamed(context, LoginPage.id);
                },
                minWidth: 200.0,
                textColor: Hexcolor('#224D4D'),
              ),
              RoundedButton(
                color: Hexcolor('#E4EFEF'),
                title: 'REGISTER',
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationPage.id);
                },
                minWidth: 200.0,
                textColor: Hexcolor('#224D4D'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
