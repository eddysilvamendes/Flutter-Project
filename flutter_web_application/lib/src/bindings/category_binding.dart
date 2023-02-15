import 'package:flutter_web_application/src/controller/category_controller.dart';
import 'package:get/get.dart';

class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryController>(() => CategoryController());
  }
}
