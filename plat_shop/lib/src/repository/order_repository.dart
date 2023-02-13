import 'package:merceariaonline/src/constants/endpoints.dart';
import 'package:merceariaonline/src/models/cart_item_model.dart';
import 'package:merceariaonline/src/models/order_model.dart';
import 'package:merceariaonline/src/result/orders_result.dart';
import 'package:merceariaonline/src/services/http_manager.dart';

class OrderRepository {
  final _httpManager = HttpManager();

  Future<OrdersResult<List<OrderModel>>> getallOrders({
    required String userId,
    required String token,
  }) async {
    final result = await _httpManager
        .restRequest(url: EndPoint.getOrders, method: HttpMethod.post, body: {
      'user': userId,
    }, headers: {
      'X-Parse-Session-Token': token
    });
    if (result['result'] != null) {
      List<OrderModel> orders =
          List<Map<String, dynamic>>.from(result['result'])
              .map(OrderModel.fromJson)
              .toList();
      return OrdersResult<List<OrderModel>>.success(orders);
    } else {
      return OrdersResult.error("Não foi possivel recuperar os pedidos");
    }
  }

  Future<OrdersResult<List<CartItemModel>>> getOrdersItems({
    required String orderId,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
        url: EndPoint.getOrderItems,
        method: HttpMethod.post,
        body: {
          'orderId': orderId,
        },
        headers: {
          'X-Parse-Session-Token': token
        });
    if (result['result'] != null) {
      List<CartItemModel> items =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();
      return OrdersResult<List<CartItemModel>>.success(items);
    } else {
      return OrdersResult.error("Não foi possivel recuperar os pedidos");
    }
  }
}
