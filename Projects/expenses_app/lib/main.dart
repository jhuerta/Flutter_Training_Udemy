import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/transaction_list.dart';
import 'widgets/new_transaction.dart';
import 'dart:math';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    // var colorScheme2 = Theme.of(context).colorScheme;
    return MaterialApp(
      home: HomePage(),
      title: 'My Expenses List',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        secondaryHeaderColor: Colors.purple,
        fontFamily: 'Quicksand',
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          backgroundColor: Colors.green,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
              // bodyMedium - Font of topBar
              bodyMedium: const TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 25,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _chars = 'ABC ';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  List<Transaction> getTransactions() {
    Transaction t1 = Transaction(
      amount: 1,
      date: DateTime.now().add(const Duration(days: -1)),
      id: "1",
      title:
          "Hola excepteur sunt est irure ut fugiat velit pariatur labore elit ut consectetur.",
    );
    Transaction t2 = Transaction(
      amount: 25920,
      date: DateTime.now().add(const Duration(days: -2)),
      id: "2",
      title:
          "Lorem esse commodo nisi commodo et sint excepteur eu occaecat voluptate sunt veniam.",
    );
    Transaction t3 = Transaction(
      amount: 323,
      date: DateTime.now().add(const Duration(days: -3)),
      id: "3",
      title:
          "Sunt magna cupidatat mollit cillum laborum nisi ullamco sit duis ipsum.",
    );
    Transaction t4 = Transaction(
      amount: 468,
      date: DateTime.now().add(const Duration(days: -4)),
      id: "4",
      title: "Ut velit aliquip eu cillum anim.",
    );
    Transaction t5 = Transaction(
      amount: 579,
      date: DateTime.now().add(const Duration(days: -5)),
      id: "5",
      title:
          "Dolor sunt Lorem esse reprehenderit dolor nulla cupidatat nostrud ut dolor.",
    );

    final randomAmount = new Random();

    var transactionList = List.generate(50, (index) {
      var daysToSubstract = (-1) * (randomAmount.nextInt(100));
      return Transaction(
        amount: 50 + randomAmount.nextDouble() * 100,
        date: DateTime.now().add(Duration(days: daysToSubstract)),
        id: index.toString(),
        title: '${index.toString()} - ${getRandomString(10)}',
      );
    });

    return transactionList;
    // return [t1, t2, t3, t4, t5];
    // return [];
  }

  late List<Transaction> userTransactionList = getTransactions();

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            // onTap: () {},
            child: NewTransaction(_addNewTransaction),
            // behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    var newTransaction = Transaction(
      amount: amount,
      title: title,
      date: date,
      id: DateTime.now().toString(),
    );

    setState(() {
      userTransactionList.add(newTransaction);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      userTransactionList.removeWhere((element) => element.id == id);
      // userTransactionList =
      //     userTransactionList.where((element) => element.id != id).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var appBarWidget = buildAppBar(context);
    var heightAppBar = appBarWidget.preferredSize.height;
    var topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBarWidget,
      body: userTransactionList.isEmpty
          ? noTransactionWidget()
          : BodyWidget(deleteTransaction, userTransactionList,
              heightAppBar + topPadding),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_startAddNewTransaction(context)},
        child: const Icon(Icons.add),
      ),
    );
  }

  Row noTransactionWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text("No transactions yet"),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 200,
              child: Image.asset('assets/images/waiting.png'),
            ),
          ],
        ),
      ],
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'My Expenses App',
        //style: TextStyle(fontFamily: 'Quicksand'),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => {_startAddNewTransaction(context)},
        ),
      ],
    );
  }
}

class BodyWidget extends StatelessWidget {
  List<Transaction> userTransactionList;
  Function(String id) deleteTransaction;
  double totalTopBarsHeight;

  BodyWidget(
      this.deleteTransaction, this.userTransactionList, this.totalTopBarsHeight,
      {super.key});

  @override
  Widget build(BuildContext context) {
    var titleSection = Card(
      elevation: 5,
      child: Container(
        color: Theme.of(context).primaryColorDark,
        width: double.infinity,
        child: const Text('List of expenses.'),
      ),
    );

    var availableHeight =
        (MediaQuery.of(context).size.height - totalTopBarsHeight);

    var bodyWidget = SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          titleSection,
          ChartWidget(availableHeight, transactionsForChart),
          TransactionList(
              availableHeight, deleteTransaction, transactionsForList),
        ],
      ),
    );

    // var chartWidget = ChartWidget(userTransactionList);
    // var values = chartWidget.groupedTransactionsValues;
    // print(values);

    return bodyWidget;
  }

  List<Transaction> get transactionsForList {
    return userTransactionList
        // .where((element) => element.date
        //     .isAfter(DateTime.now().subtract(const Duration(days: 10))))
        .toList();
  }

  List<Transaction> get transactionsForChart {
    return userTransactionList
        // .where((element) => element.date
        //     .isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }
}
          // return element.date.isAfter(DateTime.now().subtract(7));
