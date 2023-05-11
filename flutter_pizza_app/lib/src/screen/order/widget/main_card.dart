import 'package:flutter/material.dart';
import 'package:flutter_pizza_app/src/screen/order/widget/pizza_Ingredients/pizza_ingredientes.dart';
import 'package:flutter_pizza_app/src/screen/order/widget/pizza_card_button.dart';
import 'package:flutter_pizza_app/src/screen/order/widget/pizza_details.dart';
import 'package:flutter_pizza_app/src/utils/constants.dart';

class PizzaMainCard extends StatelessWidget {
  const PizzaMainCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Card Content
        Positioned.fill(
          bottom: 50,
          left: 10,
          right: 10,
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: cardContent(),
          ),
        ),
        //Card Button
        Positioned(
          bottom: 25,
          height: pizzaCardSize,
          width: pizzaCardSize,
          left: MediaQuery.of(context).size.width / 2 - pizzaCardSize / 2,
          child: PizzaCardButton(
            onTap: () => print('Card'),
          ),
        )
      ],
    );
  }

  Column cardContent() {
    return Column(
      children: const [
        SizedBox(height: 10),
        //Pizza
        Expanded(
          flex: 4,
          child: PizzaDetails(),
        ),
        //Ingredients
        Expanded(
          flex: 2,
          child: PizzaIngredients(),
        ),
      ],
    );
  }
}
