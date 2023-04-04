import 'package:flutter/material.dart';
import './question.dart';

class Answer extends StatelessWidget {
  final String answerText;
  final Function onPressed;
  Answer(this.answerText, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
      onPressed: () => {onPressed(value: answerText)},
      child: Text(
        answerText,
        style: TextStyle(
          fontSize: 12,
          backgroundColor: Colors.orange[400],
          color: Colors.yellow[400],
        ),
        textAlign: TextAlign.center,
      ),
    ));
  }
}
