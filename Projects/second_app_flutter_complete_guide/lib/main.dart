import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var questionIndex = 0;

  var questions = [
    "What's your name?",
    "What's your age?",
    "Country home?",
    "Four",
    "Five",
  ];

  void triggerQuestion() {
    print(answerQuestion());
  }

  String answerQuestion() {
    setState(() {
      questionIndex++;
      questionIndex = questionIndex % 2;
    });
    return questions[questionIndex];
  }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(home: Text("Hello World!"));

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("This is the title 2"),
      ),
      body: Row(
        children: <Widget>[
          Column(
            children: [
              Text("Line 11"),
              Text("Line 12"),
              Text("Line 13"),
              Text("Line 14"),
              ElevatedButton(
                child: Text(questions[questionIndex]),
                onPressed: triggerQuestion,
              ),
            ],
          ),
          Column(
            children: [
              Text("   "),
              Text("   "),
              Text("   "),
              Text("   "),
            ],
          ),
          Column(
            children: [
              Text("Line 21"),
              Text("Line 22"),
              Text("Line 23"),
              Text("Line 24"),
              ElevatedButton(
                child: Text(questions[1]),
                onPressed: null,
              ),
            ],
          ),
          Column(
            children: [
              Text("   "),
              Text("   "),
              Text("   "),
              Text("   "),
            ],
          ),
        ],
      ),
    ));
  }
}
