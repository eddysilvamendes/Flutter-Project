// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_expensive_app/src/screen/expenses/widget/get_expenses.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});
  static const name = 'expense_screen';
  @override
  Widget build(BuildContext context) {
    //get argument passed
    final category = ModalRoute.of(context)!.settings.arguments as String;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Expenses'),
        ),
        body: ExpenseFetcher(category: category),
      ),
    );
  }
}
