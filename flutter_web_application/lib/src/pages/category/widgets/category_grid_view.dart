import 'package:flutter/material.dart';
import 'package:flutter_web_application/src/constants/style.dart';
import 'package:flutter_web_application/src/controller/category_controller.dart';
import 'package:flutter_web_application/src/pages/category/widgets/category_form.dart';
import 'package:flutter_web_application/src/widgets/custom_text.dart';
import 'package:get/get.dart';

class CategoryGridViewPage extends GetView<CategoryController> {
  const CategoryGridViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.only(right: 8),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    //  isScrollControlled: true,
                    useSafeArea: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    context: context,
                    builder: (context) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // Get.back();
                                  },
                                  icon: const Icon(Icons.cancel)),
                            ],
                          ),
                          MyCategoryForm(),
                        ],
                      );
                    },
                  );
                },
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
        GetBuilder<CategoryController>(
          builder: (controller) {
            return SizedBox(
              height: height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: controller.allCategories.length,
                  itemBuilder: (_, index) {
                    var product = controller.allCategories[index];
                    return GestureDetector(
                      onTap: () => print(product.id),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: active,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(2, 2),
                              blurRadius: 2,
                              color: Colors.grey.shade400,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: CustomText(
                          text: product.title,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
