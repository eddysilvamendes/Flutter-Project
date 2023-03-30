import 'package:flutter/material.dart';
import 'package:flutter_expensive_app/src/db/database_provider.dart';
import 'package:flutter_expensive_app/src/screen/category/category_screen.dart';
import 'package:flutter_expensive_app/src/screen/expenses/expenses_screen.dart';
import 'package:flutter_expensive_app/src/screen/expenses/transaction/all_expenses.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => DatabaseProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      initialRoute: CategoryScreen.name,
      routes: {
        CategoryScreen.name: (_) => const CategoryScreen(),
        ExpenseScreen.name: (_) => const ExpenseScreen(),
        AllExpenses.name: (_) => const AllExpenses(),
      },
    );
  }
}
