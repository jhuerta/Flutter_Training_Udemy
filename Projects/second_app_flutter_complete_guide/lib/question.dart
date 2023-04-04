import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(1),
      color: Colors.green,
      child: Text(
        questionText,
        style: TextStyle(fontSize: 13),
        textAlign: TextAlign.center,
      ),
    );
  }
}
