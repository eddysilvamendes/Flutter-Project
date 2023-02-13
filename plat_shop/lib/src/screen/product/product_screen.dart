import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merceariaonline/src/controller/cart_controller.dart';
import 'package:merceariaonline/src/controller/navigation_controller.dart';
import 'package:merceariaonline/src/models/item_model.dart';
import 'package:merceariaonline/src/screen/common_widgets/quantity_widget.dart';
import 'package:merceariaonline/src/services/utils_services.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({
    Key? key,
  }) : super(key: key);
  final ItemModel item = Get.arguments;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int cartItemQuantity = 1;
  final navigationController = Get.find<NavigationController>();
  final cartController = Get.find<CartController>();
  final UtilsServices utilsServices = UtilsServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                    left: 30.0,
                    right: 30.0,
                    top: 60.0,
                  ),
                  height: 520.0,
                  color: const Color(0xFF32A060),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_back,
                              size: 30.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      const SizedBox(height: 5.0),
                      Text(
                        widget.item.itemName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      const Text(
                        'FROM',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        utilsServices.priceToCurrency(widget.item.price),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      const Text(
                        'UNIT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        widget.item.unit,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      RawMaterialButton(
                        padding: const EdgeInsets.all(20.0),
                        shape: const CircleBorder(),
                        elevation: 2.0,
                        fillColor: Colors.black,
                        child: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                          size: 35.0,
                        ),
                        onPressed: () {
                          Get.back();
                          cartController.addItemToCard(
                            item: widget.item,
                            quantity: cartItemQuantity,
                          );
                          //Abrir carrinho
                          navigationController.navigatePageView(
                            NavigationTabs.cart,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 20.0,
                  bottom: 30.0,
                  child: Hero(
                    tag: widget.item.imgUrl,
                    child: Image(
                      height: 300.0,
                      width: 300.0,
                      image: NetworkImage(widget.item.imgUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              //height: 260.0,
              width: double.maxFinite,
              transform: Matrix4.translationValues(0.0, -15.0, 0.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        QuantityWidget(
                          suffixText: widget.item.unit,
                          value: cartItemQuantity,
                          result: (quantity) {
                            setState(() {
                              cartItemQuantity = quantity;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                      top: 40.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'All to know...',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          widget.item.description,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 40.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          'Details',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Plant height: 35-45cm',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Nursery pot width: 12cm',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
