import 'package:flutter_web_application/src/constants/endpoints.dart';
import 'package:flutter_web_application/src/models/category_model.dart';
import 'package:flutter_web_application/src/result/category_result.dart';
import 'package:flutter_web_application/src/services/http_manager.dart';

class CategoryRepository {
  final HttpManager _httpManager = HttpManager();

  Future<CategoryResult<CategoryModel>> getAllCategories() async {
    final result = await _httpManager.restRequest(
      url: EndPoint.getCategory,
      method: HttpMethod.post,
    );

    if (result['result'] != null) {
      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CategoryModel.fromJson)
              .toList();
      return CategoryResult<CategoryModel>.success(data);
    } else {
      return CategoryResult.error(
          "Ocorreu um erro inesperado ao recuperar as categorias");
    }
  }

  Future<CategoryResult> createCategory(CategoryModel categoryModel) async {
    print('Json: ${categoryModel.toJson().toString()}');
    final result = await _httpManager.restRequest(
        url: EndPoint.createCategory,
        method: HttpMethod.post,
        body: categoryModel.toJson());
    if (result['result'] != null) {
      //utilsServices.showToast(message: 'New Credit Card!');
      print('Inserted');
      return CategoryResult<String>.Isuccess(result['result']);
    } else {
      return CategoryResult.error("Não foi possiver registrar");
    }
  }
}
