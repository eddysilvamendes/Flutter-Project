import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_application/src/conntroller/prodcutController.dart';
import 'package:flutter_web_application/src/constants/style.dart';
import 'package:flutter_web_application/src/widgets/custom_text.dart';
import 'package:flutter_web_application/src/widgets/custon_text_field.dart';
import 'package:get/get.dart';

class MyTextForm extends GetView<ProductController> {
  MyTextForm({super.key});
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    String dropdownValue = list.first;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: width / 2,
      child: Column(
        children: [
          const CustomText(
            text: 'Create Product',
            size: 26,
            weight: FontWeight.bold,
          ),
          const SizedBox(height: 50),
          SizedBox(
            width: width / 2,
            child: const CustomTextField(
              label: 'Title',
              icon: Icons.title,
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: width / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Expanded(
                  child: CustomTextField(
                    label: 'Price',
                    icon: Icons.monetization_on_outlined,
                    textInputType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: CustomTextField(
                    label: 'Quantity',
                    icon: Icons.show_chart_rounded,
                    textInputType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: width / 2,
            child: const CustomTextField(
              label: 'Quantity',
              icon: Icons.show_chart_rounded,
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
                          border: Border.all(color: Colors.grey, width: 1.5),
                        ),
                        buttonPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        isExpanded: true,
                        items: pController.category
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
                          border: Border.all(color: Colors.grey, width: 1.5),
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
                        value: pController.selectedValue,
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
            child: const CustomTextField(
              label: 'Description',
              maxLines: 5,
            ),
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Is Activate'),
                Switch(
                  // This bool value toggles the switch.
                  value: controller.light.value,
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
              onPressed: () {
                print('Printed');
              },
              child: const CustomText(
                text: "Login",
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
