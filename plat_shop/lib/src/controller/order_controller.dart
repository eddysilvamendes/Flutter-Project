import 'package:get/get.dart';
import 'package:merceariaonline/src/controller/auth_controller.dart';
import 'package:merceariaonline/src/models/cart_item_model.dart';
import 'package:merceariaonline/src/models/order_model.dart';
import 'package:merceariaonline/src/repository/order_repository.dart';
import 'package:merceariaonline/src/result/orders_result.dart';
import 'package:merceariaonline/src/services/utils_services.dart';

class OrderController extends GetxController {
  final ordersRepository = OrderRepository();
  final authController = Get.find<AuthController>();
  final utilServices = UtilsServices();
  OrderModel order;
  OrderController(this.order);
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> getOrderItems() async {
    setLoading(true);
    final OrdersResult<List<CartItemModel>> result =
        await ordersRepository.getOrdersItems(
      orderId: order.id,
      token: authController.user.token!,
    );
    setLoading(false);
    result.when(
      success: (items) {
        order.items = items;
        update();
      },
      error: (message) {
        utilServices.showToast(message: message, isError: true);
      },
    );
  }
}
