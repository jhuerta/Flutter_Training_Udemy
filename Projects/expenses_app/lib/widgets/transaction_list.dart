import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions;

  TransactionList(List<Transaction> this.transactions, {super.key}) {}

  Card buildTransactionCard(Transaction transaction) {
    return Card(
      shadowColor: Colors.blueGrey,
      elevation: 10,
      margin: const EdgeInsets.fromLTRB(1, 2, 1, 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.red[50],
            border: Border.all(color: Colors.red, width: 2)),
        child: Row(children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                color: Colors.purple[50]),
            child: Text(
              '\$${transaction.amount}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.purple,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.green[50],
                border: Border.all(color: Colors.green, width: 2)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                      DateFormat('dd MMM yyyy @')
                          .add_jm()
                          .format(transaction.date),
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  Text(transaction.title),
                ]),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    transactions.sort((b, a) => (a.date.compareTo(b.date)));
    var transactionsSection = Container(
      height: 450,
      child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            return buildTransactionCard(transactions[index]);
          }),

      // crossAxisAlignment: CrossAxisAlignment.stretch,
      // children: transactions.map((tx) {
      //   return buildTransactionCard(tx);
      // }).toList(),
    );
    return transactionsSection;
  }
}
