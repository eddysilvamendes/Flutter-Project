import 'package:flutter_web_application/src/constants/endpoints.dart';
import 'package:flutter_web_application/src/models/item_model.dart';
import 'package:flutter_web_application/src/result/product_result.dart';
import 'package:flutter_web_application/src/services/http_manager.dart';

ItemModel item = ItemModel();

class ProductRepository {
  final HttpManager _httpManager = HttpManager();

  Future<ProductResult> createProduct(ItemModel itemModel) async {
    final result = await _httpManager.restRequest(
        url: EndPoint.createProduct,
        method: HttpMethod.post,
        body: itemModel.toJson());
    if (result['result'] != null) {
      //utilsServices.showToast(message: 'New Credit Card!');
      print('Inserted');
      return ProductResult<String>.success(result['result']);
    } else {
      return ProductResult.error("Não foi possiver registrar");
    }
  }

  Future<ProductResult<ItemModel>> getAllProducts() async {
    final result = await _httpManager.restRequest(
        url: EndPoint.getProduct, method: HttpMethod.post);
    if (result['result'] != null) {
      List<ItemModel> data = (List<Map<String, dynamic>>.from(result['result']))
          .map(ItemModel.fromJson)
          .toList();
      return ProductResult<ItemModel>.getSuccess(data);
    } else {
      return ProductResult.error(
          "Ocorreu um erro inesperado ao recuperar os Productos");
    }
  }
}
