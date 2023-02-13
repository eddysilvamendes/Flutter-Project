import 'package:get/get.dart';
import 'package:merceariaonline/src/controller/cart_controller.dart';

class CartBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CartController>(
      CartController(),
    );
  }
}
