// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_application/src/constants/style.dart';
import 'package:flutter_web_application/src/controller/category_controller.dart';
import 'package:flutter_web_application/src/controller/prodcutController.dart';
import 'package:flutter_web_application/src/models/item_model.dart';
import 'package:flutter_web_application/src/services/validators.dart';
import 'package:flutter_web_application/src/widgets/custom_text.dart';
import 'package:flutter_web_application/src/widgets/custon_text_field.dart';
import 'package:get/get.dart';

class EditProductPage extends GetView<ProductController> {
  EditProductPage({
    super.key,
    required this.itemModel,
  });
  final ItemModel itemModel;
  String? selectedValue;
  var categoryController = Get.find<CategoryController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: itemModel.itemName);
    TextEditingController priceController =
        TextEditingController(text: itemModel.price.toString());
    TextEditingController quantityController =
        TextEditingController(text: itemModel.stock.toString());
    TextEditingController descriptionController =
        TextEditingController(text: itemModel.description);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(2, 2),
            blurRadius: 2,
            color: Colors.grey.shade400,
            spreadRadius: 2,
          ),
        ],
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.10,
                  ),
                  SizedBox(
                    height: height * 0.4,
                    //color: Colors.red,
                    child: Hero(
                      tag: '${itemModel.imgUrl}',
                      child: Image.network(
                        itemModel.imgUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const CustomText(
                    text: 'Update Product',
                    size: 26,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: width / 2,
                    child: CustomTextField(
                      label: '${itemModel.itemName}',
                      icon: Icons.title,
                      controller: titleController,
                      validator: titleValidator,
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: width / 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: '${itemModel.price}',
                            icon: Icons.monetization_on_outlined,
                            textInputType: TextInputType.number,
                            controller: priceController,
                            validator: priceValidator,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: CustomTextField(
                            label: '${itemModel.stock}',
                            icon: Icons.show_chart_rounded,
                            textInputType: TextInputType.number,
                            controller: quantityController,
                            validator: quantityValidator,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  GetBuilder<ProductController>(builder: (pController) {
                    return SizedBox(
                      width: width / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Category
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                hint: Text(
                                  'Select Category',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                buttonDecoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 1.5),
                                ),
                                buttonPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                isExpanded: true,
                                items: categoryController.allCategories
                                    .map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item.id,
                                    child: Text(
                                      item.title,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                value: pController.selectedCategory,
                                onChanged: (value) {
                                  pController.selectCategory(value!);
                                },
                                buttonHeight: 40,
                                buttonWidth: 140,
                                itemHeight: 40,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          //UNit
                          Expanded(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                hint: Text(
                                  'Select Unity',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                buttonDecoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 1.5),
                                ),
                                buttonPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                isExpanded: true,
                                items: pController.items
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                value: pController.selectedUnity,
                                onChanged: (value) {
                                  pController.selectUnit(value!);
                                },
                                buttonHeight: 40,
                                buttonWidth: 140,
                                itemHeight: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: width / 2,
                    child: CustomTextField(
                      label: itemModel.description!.isNotEmpty
                          ? '${itemModel.description}'
                          : 'Description',
                      maxLines: 5,
                      controller: descriptionController,
                    ),
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Is Activate'),
                        Switch(
                          // This bool value toggles the switch.
                          value: controller.isSelling.value,
                          activeColor: Colors.green,
                          onChanged: (bool value) {
                            controller.changeSwitch(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: width / 2,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        backgroundColor: active,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        elevation: 2,
                      ),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        /*   if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          controller.createProduct(
                            product: ItemModel(
                              description: descriptionController.text,
                              imgUrl:
                                  'https://www.vuescript.com/wp-content/uploads/2018/11/Show-Loader-During-Image-Loading-vue-load-image.png',
                              isActive: controller.isSelling.value,
                              itemName: titleController.text,
                              price: double.parse(priceController.text),
                              stock: double.parse(quantityController.text),
                              unit: controller.selectedUnity,
                              categoryId: controller.selectedCategory,
                            ),
                          );
                        }*/

                        print('Title: ${titleController.text}');
                        print('price: ${itemModel.price}');
                        print('stock: ${quantityController.text}');
                        print('discription: ${descriptionController.text}');

                        print('Created');
                        Navigator.pop(context);
                      },
                      child: const CustomText(
                        text: "Edit",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
