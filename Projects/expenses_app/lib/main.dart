import 'package:flutter/material.dart';
import 'widgets/user_transactions.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Expenses List',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: BodyWidget(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text('My Expenses App'),
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var titleSection = Card(
      elevation: 5,
      child: Container(
        color: Colors.blue,
        width: double.infinity,
        child: const Text('Top Car'),
      ),
    );

    var bodyWidget = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        titleSection,
        const UserTransactions(),
      ],
    );

    return bodyWidget;
  }
}
