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
}
