import 'package:flutter/material.dart';
import 'package:flutter_web_application/src/constants/controllers.dart';
import 'package:flutter_web_application/src/helpers/responsiveness.dart';
import 'package:flutter_web_application/src/pages/clients/widgets/client_table.dart';
import 'package:flutter_web_application/src/widgets/custom_text.dart';
import 'package:get/get.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                  )),
            ],
          ),
        ),
        Expanded(
            child: ListView(
          children: const [
            ClientsTable(),
          ],
        )),
      ],
    );
  }
}
