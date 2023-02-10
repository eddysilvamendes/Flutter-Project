import 'package:flutter/material.dart';
import 'package:flutter_web_application/src/pages/overview/widgets/info_card.dart';

class OverviewCardsLargeScreen extends StatelessWidget {
  const OverviewCardsLargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        InfoCard(
          title: 'Rides in progress',
          value: '7',
          onTap: () {},
          topColor: Colors.orange,
        ),
        SizedBox(width: width / 64),
        InfoCard(
          title: 'Packages delivered',
          value: '14',
          onTap: () {},
          topColor: Colors.lightGreen,
        ),
        SizedBox(width: width / 64),
        InfoCard(
          title: 'Schedules deliveries',
          value: '3',
          onTap: () {},
        ),
        SizedBox(width: width / 64),
        InfoCard(
          title: 'Cancelled deliveries',
          value: '7',
          onTap: () {},
          topColor: Colors.redAccent,
        ),
      ],
    );
  }
}
