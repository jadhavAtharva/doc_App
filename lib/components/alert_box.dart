import 'package:flutter/material.dart';

class AlertBox extends StatelessWidget {

  AlertBox({@required this.title, @required this.message, @required this.button, @required this.buttonColor, @required this.titleColor});
  final String title;
  final String message;
  final String button;
  final Color titleColor;
  final Color buttonColor;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Source Sans pro',
          color: titleColor,
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
            color: buttonColor,
            elevation: 5.0,
            child: Text(
              button,
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
  }
}
