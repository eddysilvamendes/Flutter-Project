import 'package:get/get.dart';
import 'package:merceariaonline/src/controller/all_order_controller.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AllOrderController());
  }
}
