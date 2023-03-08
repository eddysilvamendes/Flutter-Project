import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Expense {
  final int id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;
  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      //'id': id,
      'title': title,
      'amount': amount.toString(),
      'date': date.toString(),
      'category': category,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      amount: double.parse(map['amount']),
      date: DateTime.parse(map['date']),
      category: map['category'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source) as Map<String, dynamic>);
}
