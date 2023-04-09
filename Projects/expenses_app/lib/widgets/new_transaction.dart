import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? "No date chosen"
                            : DateFormat.yMd().format(_selectedDate!),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _presentDatePicker,
                        child: const Text(
                          "Pick Date",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 10),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: addNewExpense,
                child: const Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );

    return actionSection;
  }
}
