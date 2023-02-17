// ignore_for_file: avoid_print

import 'package:flutter_web_application/src/models/category_model.dart';
import 'package:flutter_web_application/src/repository/category_repository.dart';
import 'package:flutter_web_application/src/result/category_result.dart';
import 'package:flutter_web_application/src/services/utils_services.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final categoryRepository = CategoryRepository();
  List<CategoryModel> allCategories = [];
  final utilServices = UtilsServices();
  CategoryModel? currentCategory;
  bool isCategoryLoading = false;
  RxBool isActive = true.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    getAllCategories();
  }

  void setLoading(bool value, {bool isProduct = false}) {
    isCategoryLoading = value;

    update();
  }

  changeSwitch(bool value) {
    isActive.value = value;
  }

  Future<void> getAllCategories() async {
    setLoading(true);
    CategoryResult<CategoryModel> categoryResult =
        await categoryRepository.getAllCategories();
    setLoading(false);

    categoryResult.when(
      success: (data) {
        allCategories.assignAll(data);

        print('Category list ${allCategories.toString()}');
        if (allCategories.isEmpty) return;
      },
      error: (message) {
        utilServices.showToast(
          message: message,
          isError: true,
        );
      },
      Isuccess: (data) {},
    );
  }

  Future<void> createCategory({required CategoryModel category}) async {
    isLoading.value = true;
    CategoryResult result = await categoryRepository.createCategory(category);
    print('Result is: ${result.toString()}');
    isLoading.value = false;
    result.when(
      Isuccess: (item) async {
        item = item;
        await getAllCategories();
        update();
      },
      error: (message) {
        print('Error at inserting');
      },
      success: (data) {},
    );
  }
}
