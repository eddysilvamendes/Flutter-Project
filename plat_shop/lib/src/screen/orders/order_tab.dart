import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merceariaonline/src/controller/all_order_controller.dart';
import 'package:merceariaonline/src/screen/orders/components/order_tile.dart';

class OrderTab extends StatelessWidget {
  const OrderTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Pedidos'),
      ),
      body:
          //============Dados do backend===============
          GetBuilder<AllOrderController>(
        builder: (orderController) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) => OrderTile(
              order: orderController.allOrder[index],
            ),
            separatorBuilder: (_, index) => const SizedBox(height: 10),
            itemCount: orderController.allOrder.length,
          );
        },
      ),
      //=========Dados locais===============
      /* ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) => OrderTile(
          order: appData.orders[index],
        ),
        separatorBuilder: (_, index) => const SizedBox(height: 10),
        itemCount: appData.orders.length,
      ),*/
    );
  }
}
