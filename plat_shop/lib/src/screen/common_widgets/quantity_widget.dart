import 'package:flutter/material.dart';
import 'package:merceariaonline/src/config/constom_colors.dart';

class QuantityWidget extends StatelessWidget {
  const QuantityWidget(
      {Key? key,
      required this.value,
      required this.suffixText,
      required this.result,
      this.isRemovable = false})
      : super(key: key);
  final int value;
  final String suffixText;
  final Function(int quantity) result;
  final bool isRemovable;

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 200,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 2,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _quantityButton(
            color: !isRemovable || value > 1 ? Colors.grey : Colors.red,
            icon:
                !isRemovable || value > 1 ? Icons.remove : Icons.delete_forever,
            onTap: () {
              if (value == 1 && !isRemovable) return;
              int resultCount = value - 1;
              result(resultCount);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              '$value $suffixText',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _quantityButton(
            color: CustomColors.customSwatchColor,
            icon: Icons.add,
            onTap: () {
              int resultCount = value + 1;
              result(resultCount);
            },
          )
        ],
      ),
    );
  }
}

class _quantityButton extends StatelessWidget {
  const _quantityButton({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.color,
  }) : super(key: key);

  final VoidCallback onTap;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTap,
        child: Ink(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }
}
