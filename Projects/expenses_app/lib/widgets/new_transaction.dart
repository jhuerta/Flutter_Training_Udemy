import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  Function(String title, double amount) addNewTransaction;

  NewTransaction(this.addNewTransaction, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void addNewExpense() {
    var text = titleController.text;
    var amount = double.parse(amountController.text);
    if (text.isEmpty || amount <= 0) {
      return;
    }
    widget.addNewTransaction(text, amount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    var actionSection = Card(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
              onSubmitted: (_) => addNewExpense(),
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
              onSubmitted: (_) => addNewExpense(),
            ),
            ElevatedButton(
              onPressed: addNewExpense,
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );

    return actionSection;
  }
}
