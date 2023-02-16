import 'package:flutter/material.dart';
import 'package:flutter_web_application/src/controller/category_controller.dart';
import 'package:flutter_web_application/src/constants/style.dart';
import 'package:flutter_web_application/src/services/validators.dart';
import 'package:flutter_web_application/src/widgets/custom_text.dart';
import 'package:flutter_web_application/src/widgets/custon_text_field.dart';
import 'package:get/get.dart';

class MyCategoryForm extends GetView<CategoryController> {
  MyCategoryForm({super.key});

  String? selectedValue;
  var categoryController = Get.find<CategoryController>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: width / 2,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const CustomText(
              text: 'Create Category',
              size: 26,
              weight: FontWeight.bold,
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: width / 2,
              child: CustomTextField(
                label: 'Title',
                icon: Icons.title,
                controller: titleController,
                validator: titleValidator,
              ),
            ),
            const SizedBox(width: 20),

            /*
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
            ),*/
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
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }

                  print('Created');
                  Navigator.pop(context);
                },
                child: const CustomText(
                  text: "Login",
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
