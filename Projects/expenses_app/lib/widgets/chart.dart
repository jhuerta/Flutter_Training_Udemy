import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class ChartWidget extends StatelessWidget {
  const ChartWidget(this.thisWeekTransactions, {super.key});
  final List<Transaction> thisWeekTransactions;

  List<Map> get groupedTransactionsValues {
    double totalExpensesPerWeek = 0;

    var totalExpenditurePerWeek = thisWeekTransactions.forEach((element) {
      totalExpensesPerWeek += element.amount;
    });

    return List.generate(7, (dayOfWeekNumber) {
      return generateDayRecord(dayOfWeekNumber, totalExpensesPerWeek);
    });
  }

  double Normalize(
      double val, double valmin, double valmax, double min, double max) {
    return (((val - valmin) / (valmax - valmin)) * (max - min)) + min;
  }

  Map<dynamic, dynamic> generateDayRecord(
      int dayOfWeekNumber, double totalExpensesPerWeek) {
    final weekDay = DateTime.now().subtract(Duration(days: dayOfWeekNumber));
    double dayOfWeekTotalSum = 0;

    thisWeekTransactions
        .where((element) => element.date.weekday == (1 + dayOfWeekNumber))
        .forEach((element) {
      dayOfWeekTotalSum += element.amount;
    });

    return {
      'day': DateFormat('E').format(weekDay),
      'amount': dayOfWeekTotalSum.toStringAsFixed(2),
      'percentage':
          ((dayOfWeekTotalSum / totalExpensesPerWeek) * 100).toStringAsFixed(2),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: listOFBars,
      ),
    );
  }

  List<Widget> get listOFBars {
    var amounts = groupedTransactionsValues
        .map((e) => double.parse(e['amount']))
        .toList();
    var maxAmount = amounts.reduce(math.max);
    var minAmount = amounts.reduce(math.min);
    var bars = groupedTransactionsValues.map((e) {
      var normalizedExpense = Normalize(
        double.parse(e['amount']),
        minAmount,
        maxAmount,
        0,
        100,
      );
      var percentageExpense = double.parse(e['percentage']);

      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(e['day']),
          Container(
            height: 100,
            width: 10,
            child: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
              FractionallySizedBox(
                heightFactor: normalizedExpense / 100,
                child: Container(
                  width: 50,
                  height: normalizedExpense,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentageExpense / 100,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(206, 201, 90, 26),
                  ),
                ),
              )
              // Container(
              //   width: 50,
              //   height: percentageExpense,
              //   decoration: const BoxDecoration(
              //     color: Color.fromARGB(206, 201, 90, 26),
              //   ),
              // ),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 2),
            width: 40,
            child: FittedBox(
                child: Text(
              style: TextStyle(color: Colors.green),
              '\$${double.parse(e['amount']).toStringAsFixed(2)}',
            )),
          ),
        ],
      );
    }).toList();

    return bars;
  }
}
