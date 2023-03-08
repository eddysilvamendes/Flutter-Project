import 'package:flutter/material.dart';
import 'package:flutter_expensive_app/src/db/database_provider.dart';
import 'package:flutter_expensive_app/src/screen/category/widget/total_chart.dart';
import 'package:flutter_expensive_app/src/screen/expenses/expenses_screen.dart';
import 'package:flutter_expensive_app/src/screen/expenses/transaction/all_expenses.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late Future _categoryList;
  Future _getCategoryList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.getCategories();
  }

  @override
  void initState() {
    _categoryList = _getCategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _categoryList,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else {
            return Column(
              children: [
                const SizedBox(
                  height: 250.0,
                  child: TotalChart(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Expenses',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AllExpenses.name);
                        },
                        child: const Text('View All'),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: CategoryList(),
                ),
              ],
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        var list = db.categories;
        return ListView.builder(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: list.length,
          itemBuilder: (_, i) => ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(
                ExpenseScreen.name,
                arguments: list[i].title,
              );
            },
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(list[i].icon),
            ),
            title: Text(list[i].title),
            subtitle: Text('entries: ${list[i].entries}'),
            trailing: Text('\$ ${list[i].totalAmount.toStringAsFixed(2)}'),
          ),
        );
      },
    );
  }
}
