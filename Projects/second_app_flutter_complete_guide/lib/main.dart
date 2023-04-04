import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;

  static const _questionTexts = const [
    "Question_11A",
    "Question_22B",
    "Question_33C",
    "Question_44D",
  ];
  var quiz = [
    {
      "question": _questionTexts[0],
      "answers": ["aa1", "aa2", "aa3", "aa4"]
    },
    {
      "question": _questionTexts[1],
      "answers": ["bb", "bb2", "bb3", "bb4"]
    },
    {
      "question": _questionTexts[2],
      "answers": ["c1", "c2", "c3", "c4"]
    },
    {
      "question": _questionTexts[3],
      "answers": ["d1", "d2", "d3", "d4"]
    },
  ];

  String _textQuestion_1 = _questionTexts[0];
  // String _textQuestion_2 = _questionTexts[1];

  var questions = [
    "What's your name?",
    "What's your age?",
    "Country home?",
    "Four",
    "Five",
  ];

  void triggerQuestion({String value = ""}) {
    setState(() {
      _questionIndex++;
      _questionIndex = _questionIndex % 2;
      print(value);
      _textQuestion_1 = quiz[0]['question'].toString() + ": " + value;
      // _textQuestion_2 = quiz[1]['question'].toString() + ": " + value;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build is called ++++++++++++++");
    // return MaterialApp(home: Text("Hello World!"));

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("This is the title 2"),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          ...(quiz[0]['answers'] as List<String>).map((answer) {
            return Answer(answer, triggerQuestion);
          }).toList(),
          Center(
            child: Text(
              _textQuestion_1,
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
            child: Text('Reset'),
            onPressed: null,
          )
        ],
      )),
    ));
  }
}
