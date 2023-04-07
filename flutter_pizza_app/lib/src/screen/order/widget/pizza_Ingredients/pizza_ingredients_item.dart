// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_pizza_app/src/model/ingredient_model.dart';

class PizzaIngredientItem extends StatelessWidget {
  const PizzaIngredientItem({
    Key? key,
    required this.ingredient,
  }) : super(key: key);
  final Ingredient ingredient;

  @override
  Widget build(BuildContext context) {
    final child = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: 45,
        width: 45,
        decoration: const BoxDecoration(
          color: Color(0XFFF5EED3),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Image.asset(
            ingredient.image,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
    return Center(
      child: Draggable(
        feedback: DecoratedBox(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.white24,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0,
                )
              ],
            ),
            child: child),
        data: ingredient,
        child: child,
      ),
    );
  }
}
