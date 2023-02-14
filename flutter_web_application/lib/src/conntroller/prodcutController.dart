import 'package:get/get.dart';

class ProductController extends GetxController {
  RxBool light = true.obs;
  RxList<String> items = [
    'un',
    'kg',
  ].obs;
  String? selectedValue;

  RxList<String> category = [
    'Tshirt',
    'Short',
    'Shoes',
    'Drinks',
  ].obs;
  String? selectedCategory;

  changeSwitch(bool value) {
    light.value = value;
    print(light.value);
  }

  selectUnit(String value) {
    selectedValue = value;
    update();
    print(selectedValue);
  }

  selectCategory(String value) {
    selectedCategory = value;
    update();
    print(selectedCategory);
  }
}
