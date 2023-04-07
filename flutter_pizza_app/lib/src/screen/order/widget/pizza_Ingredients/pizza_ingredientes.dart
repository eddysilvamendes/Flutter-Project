import 'package:flutter/material.dart';
import 'package:flutter_pizza_app/src/model/ingredient_model.dart';

import 'package:flutter_pizza_app/src/screen/order/widget/pizza_Ingredients/pizza_ingredients_item.dart';

class PizzaIngredients extends StatelessWidget {
  const PizzaIngredients({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ingredients.length,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final ingredient = ingredients[index];
        return PizzaIngredientItem(
          ingredient: ingredient,
        );
      },
    );
  }
}
