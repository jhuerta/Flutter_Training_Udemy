import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

void main() => {MyApp()};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(home: Text("Hello World! SDFAS"));
    var questions = [
      "One",
      "Two",
      "Three",
      "Four",
      "Five",
    ];

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("This is the title"),
            ),
            body: Column(
                children: [Text('The question'), RaisedButton("The Button")])
            //Text("This is the body"),
            ));
  }
}
