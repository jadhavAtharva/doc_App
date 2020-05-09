import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';


class PrescriptionPage extends StatefulWidget {

  PrescriptionPage({this.data});

  final String data;
  static const String id = 'prescription_page';
  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/back5.jpg"),
                fit: BoxFit.cover),
        ),
        child: Scaffold(
          resizeToAvoidBottomPadding: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text('Prescription'),
            centerTitle: true,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 230.0, left: 15.0, right: 15.0),
              child: Column(
                children: <Widget>[
                  buildStack('Symptoms :', widget.data != null ? json.decode(widget.data)["Symptoms"] : ''),
                  buildStack('Diagnosis :', widget.data != null ? json.decode(widget.data)["Diagnosis"] : ''),
                  buildStack('Prescription :', widget.data != null ? json.decode(widget.data)["Prescription"] : ''),
                  buildStack('Advice :', widget.data != null ? json.decode(widget.data)["Advice"] : ''),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Stack buildStack(String text, String bodyText) {
    return Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                      padding: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Hexcolor('#224D4D'), width: 3),
                        borderRadius: BorderRadius.circular(5),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          bodyText,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Source Sans pro'
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        left: 10,
                        top: 0,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 25, left: 10, right: 10),
                          color: Colors.transparent,
                          child: Text(
                            text,
                            style: TextStyle(color: Hexcolor('#224D4D'), fontSize: 16),
                          ),
                        )),
                  ],
                );
  }
}