import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merceariaonline/src/config/constom_colors.dart';
import 'package:merceariaonline/src/controller/cart_controller.dart';
import 'package:merceariaonline/src/models/cart_item_model.dart';
import 'package:merceariaonline/src/screen/common_widgets/quantity_widget.dart';
import 'package:merceariaonline/src/services/utils_services.dart';

class CardTile extends StatefulWidget {
  const CardTile({
    Key? key,
    required this.cartItem,
  }) : super(key: key);
  final CartItemModel cartItem;

  @override
  State<CardTile> createState() => _CardTileState();
}

class _CardTileState extends State<CardTile> {
  final UtilsServices utilsServices = UtilsServices();
  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        //Image
        leading: Image.network(
          widget.cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),

        //Title
        title: Text(
          widget.cartItem.item.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),

        //Total
        subtitle: Text(
          utilsServices.priceToCurrency(widget.cartItem.totalPrice()),
          style: TextStyle(
            color: CustomColors.customSwatchColor,
            fontWeight: FontWeight.bold,
          ),
        ),

        //Quantity
        trailing: QuantityWidget(
          value: widget.cartItem.quantity,
          suffixText: widget.cartItem.item.unit,
          result: (quantity) {
            controller.changeItemQuantity(
              item: widget.cartItem,
              quantity: quantity,
            );
          },
          isRemovable: true,
        ),
      ),
    );
  }
}
