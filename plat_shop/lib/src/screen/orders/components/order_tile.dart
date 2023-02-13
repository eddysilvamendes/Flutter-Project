import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merceariaonline/src/controller/order_controller.dart';
import 'package:merceariaonline/src/models/cart_item_model.dart';
import 'package:merceariaonline/src/models/order_model.dart';
import 'package:merceariaonline/src/screen/common_widgets/payment_dialog.dart';
import 'package:merceariaonline/src/screen/orders/components/order_status.dart';
import 'package:merceariaonline/src/services/utils_services.dart';

class OrderTile extends StatelessWidget {
  OrderTile({Key? key, required this.order}) : super(key: key);

  final OrderModel order;
  final UtilsServices utilsServices = UtilsServices();
  bool isOverdue = true;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: GetBuilder<OrderController>(
          init: OrderController(order),
          global: false,
          builder: (orderController) {
            return ExpansionTile(
              onExpansionChanged: (value) {
                if (value && order.items.isEmpty) {
                  orderController.getOrderItems();
                }
              },
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Pedido: ${order.id}'),
                  Text(
                    utilsServices.formatDateTime(order.createdDateTime!),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              childrenPadding: const EdgeInsets.fromLTRB(
                16,
                0,
                16,
                16,
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
              children: orderController.isLoading
                  ? [
                      Container(
                        height: 80,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      ),
                    ]
                  : [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            // Nome do produto
                            Expanded(
                              flex: 3,
                              child: SizedBox(
                                height: 150,
                                child: ListView(
                                  children: order.items.map(
                                    (e) {
                                      return _OrderItemWidget(
                                        utilsServices: utilsServices,
                                        e: e,
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            ),
                            //Divisoria Vertical
                            VerticalDivider(
                              color: Colors.grey.shade300,
                              thickness: 1.5,
                              width: 8,
                            ),
                            //Status
                            Expanded(
                              flex: 2,
                              child: OrderStatus(
                                status: order.status ?? "pending_payment",
                                isOverdue: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Total
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Total ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: utilsServices.priceToCurrency(order.total),
                            )
                          ],
                        ),
                      ),

                      //Botao de pagamento
                      Visibility(
                        visible: order.status == 'pending_payment' && isOverdue,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return PaymentDialog(
                                  order: order,
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.payment,
                            size: 18,
                          ),
                          label: const Text('Ver Qr Kode de pagamento'),
                        ),
                      )
                    ],
            );
          },
        ),
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    Key? key,
    required this.utilsServices,
    required this.e,
  }) : super(key: key);

  final UtilsServices utilsServices;
  final CartItemModel e;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        children: [
          Text(
            '${e.quantity} ${e.item.unit} ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(e.item.itemName),
          ),
          Text(
            utilsServices.priceToCurrency(
              e.totalPrice(),
            ),
          ),
        ],
      ),
    );
  }
}
