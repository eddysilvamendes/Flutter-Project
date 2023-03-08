import 'package:flutter/material.dart';
import 'package:flutter_expensive_app/src/db/database_provider.dart';
import 'package:flutter_expensive_app/src/screen/expenses/widget/expense_card.dart';
import 'package:provider/provider.dart';

class AllExpensesList extends StatelessWidget {
  const AllExpensesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        var list = db.expenses;
        return list.isNotEmpty
            ? ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: list.length,
                itemBuilder: (_, i) => ExpenseCard(list[i]),
              )
            : const Center(
                child: Text('No Entries Found'),
              );
      },
    );
  }
}
