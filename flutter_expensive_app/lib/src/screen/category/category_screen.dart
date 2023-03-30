import 'package:flutter/material.dart';
import 'package:flutter_expensive_app/src/screen/expenses/widget/expense_form.dart';
import 'package:flutter_expensive_app/src/screen/category/widget/get_categories.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  static const name = '/category_screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Categories',
          ),
        ),
        body: const Categories(),
        floatingActionButton: FloatingActionButton(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => const ExpenseForm(),
            );
          },
        ),
      ),
    );
  }
}
