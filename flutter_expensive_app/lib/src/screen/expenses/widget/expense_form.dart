// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_expensive_app/src/constants/icons.dart';
import 'package:flutter_expensive_app/src/db/database_provider.dart';
import 'package:flutter_expensive_app/src/models/expense.dart';
import 'package:flutter_expensive_app/src/screen/expenses/widget/custom_text_form.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _title = TextEditingController();
  final _amount = TextEditingController();
  DateTime? _data;
  String _initialValue = 'Other';

  pickData() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now());
    if (pickedDate != null) {
      setState(() {
        _data = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextForm(
              controller: _title,
              title: 'Title of Expense',
            ),
            const SizedBox(
              height: 20.0,
            ),
            CustomTextForm(
              controller: _amount,
              title: 'Amount',
              textInputType: TextInputType.number,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(_data != null
                      ? DateFormat('dd MMMM, yyyy').format(_data!)
                      : 'Select Data'),
                ),
                IconButton(
                  onPressed: () => pickData(),
                  icon: const Icon(
                    Icons.calendar_month_outlined,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                const Expanded(
                  child: Text('Category'),
                ),
                Expanded(
                  child: DropdownButton(
                    items: icons.keys
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    value: _initialValue,
                    onChanged: (newValue) {
                      setState(() {
                        _initialValue = newValue!;
                      });
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                if (_title.text != null && _amount.text != null) {
                  final file = Expense(
                    id: 0,
                    title: _title.text,
                    amount: double.parse(_amount.text),
                    date: _data != null ? _data! : DateTime.now(),
                    category: _initialValue,
                  );
                  provider.addExpenses(file);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add Expense'),
            )
          ],
        ),
      ),
    );
  }
}
