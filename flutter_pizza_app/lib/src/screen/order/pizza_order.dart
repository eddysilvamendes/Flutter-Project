import 'package:flutter/material.dart';
import 'package:flutter_pizza_app/src/screen/order/widget/main_card.dart';

class PizzaOrderHome extends StatelessWidget {
  const PizzaOrderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Orleans Pizza',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_shopping_cart_outlined),
          ),
        ],
      ),
      body: const PizzaMainCard(),
    );
  }
}
