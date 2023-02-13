import 'package:merceariaonline/src/constants/endpoints.dart';
import 'package:merceariaonline/src/models/category_model.dart';
import 'package:merceariaonline/src/models/item_model.dart';
import 'package:merceariaonline/src/result/home_result.dart';
import 'package:merceariaonline/src/services/http_manager.dart';

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final result = await _httpManager.restRequest(
      url: EndPoint.getCategory,
      method: HttpMethod.post,
    );

    if (result['result'] != null) {
      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CategoryModel.fromJson)
              .toList();
      return HomeResult<CategoryModel>.success(data);
    } else {
      return HomeResult.error(
          "Ocorreu um erro inesperado ao recuperar as categorias");
    }
  }

  Future<HomeResult<ItemModel>> getAllProducts(
      Map<String, dynamic> body) async {
    final result = await _httpManager.restRequest(
        url: EndPoint.getProduct, method: HttpMethod.post, body: body);
    if (result['result'] != null) {
      List<ItemModel> data = (List<Map<String, dynamic>>.from(result['result']))
          .map(ItemModel.fromJson)
          .toList();
      return HomeResult<ItemModel>.success(data);
    } else {
      return HomeResult.error(
          "Ocorreu um erro inesperado ao recuperar as categorias");
    }
  }
}
