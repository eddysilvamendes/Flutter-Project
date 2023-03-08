import 'package:flutter/material.dart';
import 'package:flutter_expensive_app/src/db/database_provider.dart';
import 'package:flutter_expensive_app/src/screen/expenses/widget/expense_card.dart';
import 'package:flutter_expensive_app/src/screen/expenses/widget/expense_chart.dart';
import 'package:provider/provider.dart';

class ExpenseFetcher extends StatefulWidget {
  const ExpenseFetcher({
    Key? key,
    required this.category,
  }) : super(key: key);
  final String category;
  @override
  State<ExpenseFetcher> createState() => _ExpenseFetcherState();
}

class _ExpenseFetcherState extends State<ExpenseFetcher> {
  late Future _expenseList;
  Future _getExpenseList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.fetchExpenses(widget.category);
  }

  @override
  void initState() {
    _expenseList = _getExpenseList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _expenseList,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 250.0,
                    child: ExpenseChart(widget.category),
                  ),
                  Expanded(
                    child: Consumer<DatabaseProvider>(
                      builder: (_, db, __) {
                        var exList = db.expenses;
                        return exList.isNotEmpty
                            ? ListView.builder(
                                itemCount: exList.length,
                                itemBuilder: (_, i) => ExpenseCard(exList[i]),
                              )
                            : const Center(
                                child: Text('No Expenses Added'),
                              );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
