// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PizzaCardButton extends StatefulWidget {
  const PizzaCardButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);
  final VoidCallback onTap;

  @override
  State<PizzaCardButton> createState() => _PizzaCardButtonState();
}

class _PizzaCardButtonState extends State<PizzaCardButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 150),
        lowerBound: 1.0,
        upperBound: 1.5,
        reverseDuration: const Duration(milliseconds: 200));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _animateButton() async {
    await _animationController.forward(from: 0.0);
    await _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap;
        _animateButton();
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Transform.scale(
            scale: 2 - _animationController.value,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.orange.withOpacity(0.5),
                      Colors.orange,
                    ],
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 4.0),
                      spreadRadius: 6.0,
                    )
                  ]),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 30,
              ),
            ),
          );
        },
      ),
    );
  }
}
