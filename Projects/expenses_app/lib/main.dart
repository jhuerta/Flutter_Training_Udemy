import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/transaction_list.dart';
import 'widgets/new_transaction.dart';
import 'dart:io';
import 'dart:math';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);
  runApp(const ExpensesApp());
}

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
        floatingActionButtonTheme: FloatingActionButtonThemeData(
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
      var daysToSubstract = index % 7;
      // var daysToSubstract = (-1) * (randomAmount.nextInt(7));
      double quantity = (((daysToSubstract == 1) ||
              (daysToSubstract == 8) ||
              (daysToSubstract == 8)))
          ? 200
          : 0;
      return Transaction(
        amount: quantity,
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

  bool showChart = false;

  @override
  Widget build(BuildContext context) {
    bool isIOS = Platform.isIOS;

    isIOS = true;

    var appBar = buildAppBar(isIOS, context);

    var appBarWidget = appBar['AppBar'];
    var heightAppBar = appBar['Dimentions'] as double;
    var topPadding = MediaQuery.of(context).padding.top;
    var androidScaffold = Scaffold(
      appBar: appBarWidget as PreferredSizeWidget,
      body: userTransactionList.isEmpty
          ? noTransactionWidget()
          : BodyWidget(deleteTransaction, userTransactionList,
              heightAppBar + topPadding),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isIOS
          ? Container()
          : FloatingActionButton(
              onPressed: () => {_startAddNewTransaction(context)},
              child: const Icon(Icons.add),
            ),
    );

    var cuppertinoScaffold = isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar['AppBar'] as CupertinoNavigationBar,
            child: userTransactionList.isEmpty
                ? noTransactionWidget()
                : BodyWidget(deleteTransaction, userTransactionList,
                    heightAppBar + topPadding),
          )
        : CupertinoPageScaffold(child: Text("Not Implemented"));

    return isIOS ? cuppertinoScaffold : androidScaffold;
  }

  Row noTransactionWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LayoutBuilder(builder: (ctx, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text("No transactions yet"),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                height: constraints.maxHeight * 0.5,
                child: Image.asset('assets/images/waiting.png'),
              ),
            ],
          );
        }),
      ],
    );
  }

  AppBar androidAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Android - My Expenses App',
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

  CupertinoNavigationBar iosAppBar(BuildContext context) {
    return CupertinoNavigationBar(
      middle: Text("iOS - My Expenses App"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => {_startAddNewTransaction(context)},
          )
        ],
      ),
      backgroundColor: Colors.orange,
    );
  }

  Map<String, Object> buildAppBar(bool isIOS, BuildContext context) {
    var appBar = isIOS ? iosAppBar(context) : androidAppBar(context);
    return {
      'Dimentions': isIOS
          ? (appBar as CupertinoNavigationBar).preferredSize.height
          : (appBar as AppBar).preferredSize.height,
      'AppBar': appBar
    };
  }
}

class BodyWidget extends StatefulWidget {
  List<Transaction> userTransactionList;
  Function(String id) deleteTransaction;
  double totalTopBarsHeight;

  BodyWidget(
      this.deleteTransaction, this.userTransactionList, this.totalTopBarsHeight,
      {super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  bool showChart = false;

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var titleSection = Card(
      elevation: 5,
      child: Container(
        color: Theme.of(context).primaryColorDark,
        width: double.infinity,
        child: const Text('List of expenses.'),
      ),
    );

    var availableHeight =
        (MediaQuery.of(context).size.height - widget.totalTopBarsHeight);

    var bodyWidget = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Container(
                height: availableHeight * 0.1,
                child: Row(
                  children: [
                    Material(
                      child: Text(
                        "Show dd",
                      ),
                    ),
                    Material(
                      child: Switch.adaptive(
                          value: showChart,
                          onChanged: (value) {
                            setState(() {
                              showChart = value;
                            });
                          }),
                    ),
                  ],
                ),
              ),
            // titleSection,
            if (!isLandscape)
              Container(
                  height: availableHeight * 0.3,
                  child: ChartWidget(availableHeight, transactionsForChart)),
            if (!isLandscape)
              TransactionList(0.7, availableHeight, widget.deleteTransaction,
                  transactionsForList),
            if (isLandscape && showChart)
              Container(
                  height: availableHeight * 0.9,
                  child: ChartWidget(availableHeight, transactionsForChart)),
            if (isLandscape && !showChart)
              TransactionList(0.9, availableHeight, widget.deleteTransaction,
                  transactionsForList),
          ],
        ),
      ),
    );

    return bodyWidget;
  }

  List<Transaction> get transactionsForList {
    return widget.userTransactionList
        // .where((element) => element.date
        //     .isAfter(DateTime.now().subtract(const Duration(days: 10))))
        .toList();
  }

  List<Transaction> get transactionsForChart {
    return widget.userTransactionList
        // .where((element) => element.date
        //     .isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }
}
          // return element.date.isAfter(DateTime.now().subtract(7));
