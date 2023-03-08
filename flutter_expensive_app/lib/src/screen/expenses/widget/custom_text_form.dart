// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    Key? key,
    required this.controller,
    required this.title,
    this.textInputType,
  }) : super(key: key);
  final TextEditingController controller;
  final String title;
  final TextInputType? textInputType;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }
}
