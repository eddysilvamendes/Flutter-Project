import 'package:flutter/material.dart';
import 'package:flutter_web_application/src/controller/prodcutController.dart';
import 'package:flutter_web_application/src/pages/product/widgets/edit_product.dart';
import 'package:flutter_web_application/src/pages/product/widgets/form.dart';
import 'package:flutter_web_application/src/widgets/custom_text.dart';
import 'package:get/get.dart';

class ProductGridViewPage extends GetView<ProductController> {
  const ProductGridViewPage({super.key});

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
                    isScrollControlled: true,
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
                          MyTextForm(),
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
        GetBuilder<ProductController>(
          builder: (controller) {
            return SizedBox(
              height: height,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: controller.allProducts.length,
                  itemBuilder: (_, index) {
                    var product = controller.allProducts[index];
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.white,
                            isScrollControlled: true,
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
                                  EditProductPage(itemModel: product),
                                ],
                              );
                            },
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Hero(
                                    tag: '${product.imgUrl}',
                                    child: Image.network(
                                      product.imgUrl ??
                                          'https://www.vuescript.com/wp-content/uploads/2018/11/Show-Loader-During-Image-Loading-vue-load-image.png',
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //Name
                            Positioned(
                              top: 20,
                              right: 10,
                              child: CustomText(
                                text: product.itemName ?? 'No Name',
                                color: Colors.white,
                              ),
                            ),
                            //Bottom
                            Positioned(
                              top: 10,
                              //right: 10,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: product.isActive == true
                                      ? Colors.green
                                      : Colors.red,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Icon(
                                  product.isActive == true
                                      ? Icons.check
                                      : Icons.cancel_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
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
