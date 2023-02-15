import 'package:flutter_web_application/src/models/item_model.dart';
import 'package:flutter_web_application/src/repository/product_repository.dart';
import 'package:flutter_web_application/src/result/product_result.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxBool isSelling = true.obs;
  RxBool isLoading = false.obs;
  final ProductRepository productRepository = ProductRepository();
  ItemModel item = ItemModel();
  RxList<String> items = [
    'un',
    'kg',
  ].obs;
  String? selectedUnity;
  String? selectedCategory;

  changeSwitch(bool value) {
    isSelling.value = value;
  }

  selectUnit(String value) {
    selectedUnity = value;
  }

  selectCategory(String value) {
    selectedCategory = value;
    update();
  }

  Future<void> createProduct({required ItemModel product}) async {
    isLoading.value = true;
    ProductResult result = await productRepository.createProduct(product);

    isLoading.value = false;
    result.when(
      success: (item) {
        item = item;
      },
      error: (message) {
        print('Error at insering');
      },
    );
  }
}
