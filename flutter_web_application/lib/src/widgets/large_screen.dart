import 'package:flutter/material.dart';
import 'package:flutter_web_application/src/helpers/local_navigator.dart';
import 'package:flutter_web_application/src/widgets/side_menu.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: const SideMenu(),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: localNavigator(),
          ),
        ),
      ],
    );
  }
}
