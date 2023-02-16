import 'package:flutter_web_application/src/models/item_model.dart';
import 'package:flutter_web_application/src/repository/product_repository.dart';
import 'package:flutter_web_application/src/result/product_result.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxBool isSelling = true.obs;
  RxBool isLoading = false.obs;
  bool isProductLoading = true;
  final ProductRepository productRepository = ProductRepository();
  ItemModel item = ItemModel();
  List<ItemModel> allProducts = [];
  RxList<String> items = [
    'un',
    'kg',
  ].obs;
  String? selectedUnity;
  String? selectedCategory;

  @override
  void onInit() {
    super.onInit();

    getAllProducts();
  }

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

  void setLoading(bool value, {bool isProduct = false}) {
    isProductLoading = value;

    update();
  }

  Future<void> createProduct({required ItemModel product}) async {
    isLoading.value = true;
    ProductResult result = await productRepository.createProduct(product);

    isLoading.value = false;
    result.when(
      success: (item) async {
        item = item;
        await getAllProducts();
        update();
      },
      error: (message) {
        print('Error at insering');
      },
      getSuccess: (gdata) {},
    );
  }

  Future<void> getAllProducts({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isProduct: true);
    }

    //Cod for
    /*if (searchTitle.value.isNotEmpty) {
      body['title'] = searchTitle.value;
      if (currentCategory!.id == '') {
        body.remove('categoryId');
      }
    }*/

    ProductResult<ItemModel> homeResult =
        await productRepository.getAllProducts();
    setLoading(false, isProduct: true);

    homeResult.when(
      getSuccess: (data) {
        allProducts.assignAll(data.reversed);
        print(allProducts.toString());
      },
      error: (message) {
        print('error');
      },
      success: (data) {},
    );
  }
}
