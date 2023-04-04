// 1) Create a new Flutter App (in this project) and output an AppBar and some text
// below it
// 2) Add a button which changes the text (to any other text of your choice)
// 3) Split the app into three widgets: App, TextControl & Text

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './textControl.dart';
import './textValue.dart';

void main() => runApp(First_Assignment());

class First_Assignment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _First_AssignmentState();
  }
}

class _First_AssignmentState extends State<First_Assignment> {
  String get GetTime {
    return DateFormat('hh:mm:ss').format(DateTime.now());
  }

  void _changeValue() {
    setState(() {
      currentTime = GetTime;
    });
  }

  var currentTime = DateFormat('hh:mm:ss').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("First Assignment"),
            ),
            body: Column(children: [
              TextValue(currentTime: currentTime),
              TextControl(_changeValue)
            ])));
  }
}
