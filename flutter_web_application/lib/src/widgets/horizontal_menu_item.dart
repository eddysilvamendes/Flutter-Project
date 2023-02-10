import 'package:flutter/material.dart';
import 'package:flutter_web_application/src/constants/controllers.dart';
import 'package:flutter_web_application/src/constants/style.dart';
import 'package:flutter_web_application/src/widgets/custom_text.dart';
import 'package:get/get.dart';

class HorizontalMenuItem extends StatelessWidget {
  const HorizontalMenuItem({
    Key? key,
    required this.itemName,
    this.onTap,
  }) : super(key: key);
  final String itemName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? menuController.onHover(itemName)
            : menuController.onHover('not hovering');
      },
      child: Obx(
        () => Container(
          color: menuController.isHovering(itemName)
              ? lightGrey.withOpacity(0.1)
              : Colors.transparent,
          child: Row(
            children: [
              Visibility(
                visible: menuController.isHovering(itemName) ||
                    menuController.isActive(itemName),
                maintainSize: true,
                maintainState: true,
                maintainAnimation: true,
                child: Container(
                  width: 6,
                  height: 40,
                  color: dark,
                ),
              ),
              SizedBox(width: width / 80),
              Padding(
                padding: const EdgeInsets.all(16),
                child: menuController.returnIconFor(itemName),
              ),
              if (!menuController.isActive(itemName))
                Flexible(
                  child: CustomText(
                    text: itemName,
                    color:
                        menuController.isHovering(itemName) ? dark : lightGrey,
                  ),
                )
              else
                Flexible(
                  child: CustomText(
                    text: itemName,
                    color: dark,
                    size: 18,
                    weight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
