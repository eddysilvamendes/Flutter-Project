import 'package:flutter/material.dart';
import 'package:flutter_web_application/src/helpers/responsiveness.dart';
import 'package:flutter_web_application/src/widgets/horizontal_menu_item.dart';
import 'package:flutter_web_application/src/widgets/vertical_menu_item.dart';

class SideMenuItem extends StatelessWidget {
  const SideMenuItem({super.key, required this.itemName, this.onTap});
  final String itemName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomScreen(context)) {
      return VerticalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );
    } else {
      return HorizontalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );
    }
  }
}
