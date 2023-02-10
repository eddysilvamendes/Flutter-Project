import 'package:flutter/material.dart';
import 'package:flutter_web_application/src/constants/controllers.dart';
import 'package:flutter_web_application/src/helpers/responsiveness.dart';
import 'package:flutter_web_application/src/pages/overview/widgets/avaiable_drivers.dart';
import 'package:flutter_web_application/src/pages/overview/widgets/overview_cards_large.dart';
import 'package:flutter_web_application/src/pages/overview/widgets/overview_cards_medium.dart';
import 'package:flutter_web_application/src/pages/overview/widgets/overview_lcards_small.dart';
import 'package:flutter_web_application/src/pages/overview/widgets/reveneu_section_large.dart';
import 'package:flutter_web_application/src/pages/overview/widgets/revenue_section_small.dart';
import 'package:flutter_web_application/src/widgets/custom_text.dart';
import 'package:get/get.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

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
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              if (ResponsiveWidget.isLargeScreen(context) ||
                  ResponsiveWidget.isMediumScreen(context))
                if (ResponsiveWidget.isCustomScreen(context))
                  const OverviewCardsMediumScreen()
                else
                  const OverviewCardsLargeScreen()
              else
                const OverviewCardsSmallScreen(),
              if (!ResponsiveWidget.isSmallScreen(context))
                const RevenueSectionLargeScreen()
              else
                const RevenueSectionSmallScreen(),
              const AvailableDriversTable(),
            ],
          ),
        ),
      ],
    );
  }
}
