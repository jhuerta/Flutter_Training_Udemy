import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  late String newAmountExpense = "";
  final titleController = TextEditingController();

  Function(String title, double amount) addNewTransaction;

  NewTransaction(this.addNewTransaction, {super.key});

  void addNexExpense() {
    var amountAsDouble = double.parse(newAmountExpense);
    addNewTransaction(titleController.text, amountAsDouble);
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
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              onChanged: (val) {
                newAmountExpense = val;
              },
            ),
            ElevatedButton(
              onPressed: addNexExpense,
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );

    return actionSection;
  }
}
