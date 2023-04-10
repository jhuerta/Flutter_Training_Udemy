import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './transaction_card_item.dart';

class TransactionList extends StatefulWidget {
  List<Transaction> transactions;
  double availableHeight;
  Function(String id) deleteTransaction;
  double percentage;

  // Function(String id) deleteTransaction;

  TransactionList(this.percentage, this.availableHeight, this.deleteTransaction,
      this.transactions,
      {super.key}) {}

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  Card buildTransactionCard(Transaction transaction, BuildContext context) {
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
              '\$${transaction.amount.toStringAsFixed(2)}',
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
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    transaction.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ]),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.transactions.sort((b, a) => (a.date.compareTo(b.date)));

    var transactionsSection = Container(
        height: widget.availableHeight * widget.percentage,
        child: ListView(
            children: widget.transactions
                .map(
                  (theTransaction) => TransactionCardItem(
                    widget.deleteTransaction,
                    theTransaction,
                    ValueKey(theTransaction.id),
                  ),
                )
                .toList()));

    return transactionsSection;
  }
}
