import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merceariaonline/src/config/constom_colors.dart';
import 'package:merceariaonline/src/controller/cart_controller.dart';
import 'package:merceariaonline/src/screen/cart/components/cart_tile.dart';
import 'package:merceariaonline/src/services/utils_services.dart';
import 'package:merceariaonline/src/config/app_data.dart' as appData;

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsServices utilsServices = UtilsServices();
  double cartTotalPrice() {
    double total = 0;
    for (var item in appData.cartitem) {
      total += item.totalPrice();
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<CartController>(
              builder: (cartController) {
                if (cartController.cartItems.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_shopping_cart,
                        size: 40,
                        color: CustomColors.customSwatchColor,
                      ),
                      const Text('Não há items no carrinho')
                    ],
                  );
                }
                return ListView.builder(
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (_, index) {
                    return CardTile(
                      cartItem: cartController.cartItems[index],
                    );
                  },
                );
              },
            ),
          ),

          //TOTAL SECTION
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                GetBuilder<CartController>(
                  builder: (cartController) {
                    return Text(
                      utilsServices
                          .priceToCurrency(cartController.cartTotalPrice()),
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.customSwatchColor,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 50,
                  child: GetBuilder<CartController>(
                    builder: (cartController) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: CustomColors.customSwatchColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: cartController.isCheckOutLoading
                            ? null
                            : () async {
                                bool? result = await showOrderConfirmation();
                                if (result ?? false) {
                                  //Controller de checkOut
                                  cartController.checkOutCart();
                                } else {
                                  utilsServices.showToast(
                                      message: "Pedido nao foi confirmado");
                                }
                              },
                        child: cartController.isCheckOutLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Concluir pedido',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Confirmação'),
          content: const Text('Deseja realmente concluir o pedido?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Não'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Sim'),
            )
          ],
        );
      },
    );
  }
}
