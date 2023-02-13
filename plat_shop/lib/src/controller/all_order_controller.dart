import 'package:get/get.dart';
import 'package:merceariaonline/src/controller/auth_controller.dart';
import 'package:merceariaonline/src/models/order_model.dart';
import 'package:merceariaonline/src/repository/order_repository.dart';
import 'package:merceariaonline/src/result/orders_result.dart';
import 'package:merceariaonline/src/services/utils_services.dart';

class AllOrderController extends GetxController {
  List<OrderModel> allOrder = [];
  final orderRepository = OrderRepository();
  final authController = Get.find<AuthController>();
  final utilsSerives = UtilsServices();

  @override
  void onInit() {
    super.onInit();
    getAllOrder();
  }

  Future<void> getAllOrder() async {
    OrdersResult<List<OrderModel>> result = await orderRepository.getallOrders(
      userId: authController.user.id!,
      token: authController.user.token!,
    );

    result.when(
      success: (orders) {
        allOrder = orders;
        update();
      },
      error: (message) {
        utilsSerives.showToast(message: message, isError: true);
      },
    );
  }
}
