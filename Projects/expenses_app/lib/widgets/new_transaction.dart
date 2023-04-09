import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'adaptiveButton.dart';

class NewTransaction extends StatefulWidget {
  Function(String title, double amount, DateTime date) addNewTransaction;

  NewTransaction(this.addNewTransaction, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void addNewExpense() {
    var text = titleController.text;
    var amount = double.parse(amountController.text);
    if (text.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addNewTransaction(text, amount, _selectedDate!);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 2)),
      lastDate: DateTime.now().add(Duration(days: 2)),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var titleTextField = TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: "Title"),
      controller: titleController,
      onSubmitted: (_) => addNewExpense(),
    );

    var cupertinoTextField = CupertinoTextField(
      placeholder: "Im a cupertino box",
      controller: titleController,
      keyboardType: TextInputType.number,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 5),
      ),
    );

    var actionSection = SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              cupertinoTextField /*titleTextField*/,
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountController,
                onSubmitted: (_) => addNewExpense(),
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? "No date chosen"
                            : DateFormat.yMd().format(_selectedDate!),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      width: 150,
                      margin: EdgeInsets.all(2),
                      child: AdaptiveButton(_presentDatePicker,
                          "Chose a Date") /*pickDateButton*/,
                    ),
                  ],
                ),
              ),
              AdaptiveButton(addNewExpense, "Add")
              // ElevatedButton(
              //   onPressed: addNewExpense,
              //   child: const Text("Add"),
              // ),
            ],
          ),
        ),
      ),
    );

    return actionSection;
  }
}
