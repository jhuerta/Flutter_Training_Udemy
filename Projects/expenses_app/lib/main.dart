import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/new_transaction.dart';

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

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> getTransactions() {
    Transaction t1 = Transaction(
      amount: 1,
      date: DateTime.now().add(const Duration(days: -10)),
      id: "1",
      title:
          "Hola excepteur sunt est irure ut fugiat velit pariatur labore elit ut consectetur.",
    );
    Transaction t2 = Transaction(
      amount: 25920,
      date: DateTime.now().add(const Duration(days: -5)),
      id: "2",
      title:
          "Lorem esse commodo nisi commodo et sint excepteur eu occaecat voluptate sunt veniam.",
    );
    Transaction t3 = Transaction(
      amount: 323,
      date: DateTime.now().add(const Duration(days: -15)),
      id: "3",
      title:
          "Sunt magna cupidatat mollit cillum laborum nisi ullamco sit duis ipsum.",
    );
    Transaction t4 = Transaction(
      amount: 468,
      date: DateTime.now().add(const Duration(days: -2)),
      id: "4",
      title: "Ut velit aliquip eu cillum anim.",
    );
    Transaction t5 = Transaction(
      amount: 579,
      date: DateTime.now().add(const Duration(days: -25)),
      id: "5",
      title:
          "Dolor sunt Lorem esse reprehenderit dolor nulla cupidatat nostrud ut dolor.",
    );

    return [t1, t2, t3, t4, t5];
  }

  late List<Transaction> userTransactionList = getTransactions();

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            // onTap: () {},
            child: NewTransaction(_addNewTransaction),
            // behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _addNewTransaction(String title, double amount) {
    var newTransaction = Transaction(
      amount: amount,
      title: title,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    print(amount);
    print(title);
    setState(() {
      userTransactionList.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: BodyWidget(userTransactionList),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_startAddNewTransaction(context)},
        child: Icon(Icons.add),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('My Expenses App'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => {_startAddNewTransaction(context)},
        ),
      ],
    );
  }
}

class BodyWidget extends StatelessWidget {
  List<Transaction> userTransactionList;

  BodyWidget(this.userTransactionList, {super.key});

  @override
  Widget build(BuildContext context) {
    var titleSection = Card(
      elevation: 5,
      child: Container(
        color: Colors.blue,
        width: double.infinity,
        child: const Text('List of past expenses'),
      ),
    );

    var bodyWidget = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        titleSection,
        TransactionList(userTransactionList),
      ],
    );

    return bodyWidget;
  }
}
