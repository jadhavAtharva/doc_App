import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {

  RoundedButton({ @required this.color, @required this.title, @required this.onPressed, @required this.minWidth, this.textColor, this.elevation});
  final Color color;
  final String title;
  final Function onPressed;
  final double minWidth;
  final Color textColor;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: elevation != null ? elevation : 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: minWidth,
          height: 42.0,
          child: Text(
              title,
            style: TextStyle(
              color: textColor != null ? textColor : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
