import 'package:flutter/material.dart';

import './new_transaction.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({super.key});

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  late List<Transaction> userTransactionList = getTransactions();
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      // NewTransaction(_addNewTransaction),
      // TransactionList(userTransactionList),
    ]);
  }

  // void _addNewTransaction(String title, double amount) {
  //   var newTransaction = Transaction(
  //     amount: amount,
  //     title: title,
  //     date: DateTime.now(),
  //     id: DateTime.now().toString(),
  //   );

  //   setState(() {
  //     userTransactionList.add(newTransaction);
  //   });
  // }

  List<Transaction> getTransactions() {
    Transaction t1 = Transaction(
      amount: 1,
      date: DateTime.now().add(const Duration(days: -10)),
      id: "1",
      title:
          "---Excepteur sunt est irure ut fugiat velit pariatur labore elit ut consectetur.",
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
}
