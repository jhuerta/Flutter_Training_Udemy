import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionCardItem extends StatefulWidget {
  Function(String id) deleteCard;
  Transaction transaction;
  TransactionCardItem(this.deleteCard, this.transaction, Key key)
      : super(key: key);

  @override
  State<TransactionCardItem> createState() => _TransactionCardItemState();
}

class _TransactionCardItemState extends State<TransactionCardItem> {
  late final Color _bgColor;
  var colors = [
    Colors.red,
    Colors.orange,
    Colors.brown,
    Colors.yellow,
    Colors.blue,
    Colors.green
  ];

  @override
  void initState() {
    _bgColor = colors[Random().nextInt(6)];
    super.initState();
  }

  @override
  Card build(BuildContext context) {
    print(
        'Id ${widget.transaction.id} - Color ${_bgColor.value.toString().substring(_bgColor.value.toString().length - 2)}');
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        title: Text(widget.transaction.title),
        subtitle: Text(DateFormat.yMd().format(widget.transaction.date)),
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 25,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: FittedBox(
                child: Text(widget.transaction.amount.toStringAsFixed(2))),
          ),
        ),
        trailing: BuildIconButton(widget.transaction, context),
      ),
    );
  }

  Widget BuildIconButton(Transaction transaction, BuildContext context) {
    bool bigScreen = MediaQuery.of(context).size.width > 400;
    ;
    var smallButton = IconButton(
      onPressed: () {
        widget.deleteCard(transaction.id);
      },
      icon: Icon(Icons.delete),
      color: Theme.of(context).colorScheme.error,
    );

    var bigButton = ElevatedButton.icon(
      icon: Icon(Icons.delete),
      style: const ButtonStyle(
        iconColor:
            MaterialStatePropertyAll<Color>(Color.fromARGB(255, 238, 5, 207)),
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
        foregroundColor:
            MaterialStatePropertyAll<Color>(Color.fromARGB(255, 255, 17, 0)),
        elevation: MaterialStatePropertyAll(0),
      ),
      label: Text("Delete Transaction"),
      onPressed: () {
        widget.deleteCard(transaction.id);
      },
    );

    return bigScreen ? bigButton : smallButton;
  }
}
