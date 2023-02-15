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
  @override
  void onInit() {
    super.onInit();

    getAllCategories();
  }

  void setLoading(bool value, {bool isProduct = false}) {
    isCategoryLoading = value;

    update();
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
    );
  }
}
