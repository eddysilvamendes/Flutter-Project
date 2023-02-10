import 'package:flutter/material.dart';
import 'package:flutter_web_application/src/pages/overview/widgets/info_card.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  const OverviewCardsSmallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
            title: 'Rides in progress',
            value: '7',
            onTap: () {},
            isActive: true,
          ),
          SizedBox(height: width / 64),
          InfoCardSmall(
            title: 'Packages delivered',
            value: '14',
            onTap: () {},
          ),
          SizedBox(height: width / 64),
          InfoCardSmall(
            title: 'Schedules deliveries',
            value: '3',
            onTap: () {},
          ),
          SizedBox(height: width / 64),
          InfoCardSmall(
            title: 'Cancelled deliveries',
            value: '7',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
