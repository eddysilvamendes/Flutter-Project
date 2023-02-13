import 'package:flutter/material.dart';
import 'package:merceariaonline/src/config/constom_colors.dart';

class AppName extends StatelessWidget {
  final Color? color;
  final double size;

  const AppName({Key? key, this.color, this.size = 30}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(fontSize: size),
        children: [
          TextSpan(
            text: 'Plant\'s',
            style: TextStyle(color: color ?? CustomColors.customContrastColor),
          ),
        ],
      ),
    );
  }
}
