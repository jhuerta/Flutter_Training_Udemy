import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions;
  double availableHeight;
  Function(String id) deleteTransaction;

  // Function(String id) deleteTransaction;

  TransactionList(
      this.availableHeight, this.deleteTransaction, this.transactions,
      {super.key}) {}

  Card buildTransactionTile(Transaction transaction, BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        title: Text(transaction.title),
        subtitle: Text(DateFormat.yMd().format(transaction.date)),
        leading: CircleAvatar(
          radius: 25,
          child: Padding(
            padding: EdgeInsets.all(5),
            child:
                FittedBox(child: Text(transaction.amount.toStringAsFixed(2))),
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            deleteTransaction(transaction.id);
          },
          icon: Icon(Icons.delete),
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }

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
    transactions.sort((b, a) => (a.date.compareTo(b.date)));
    var transactionsSection = Container(
      height: availableHeight * 0.6,
      child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            return buildTransactionTile(transactions[index], context);
            // return buildTransactionCard(transactions[index], context);
          }),

      // crossAxisAlignment: CrossAxisAlignment.stretch,
      // children: transactions.map((tx) {
      //   return buildTransactionCard(tx);
      // }).toList(),
    );
    return transactionsSection;
  }
}
