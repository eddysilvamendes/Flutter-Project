import 'package:flutter/material.dart';
import 'package:flutter_web_application/src/constants/style.dart';
import 'package:flutter_web_application/src/widgets/custom_text.dart';

class InfoCard extends StatelessWidget {
  const InfoCard(
      {super.key,
      this.title,
      this.value,
      this.topColor,
      this.isActive = false,
      this.onTap});
  final String? title;
  final String? value;
  final Color? topColor;
  final bool? isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 136,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 6),
                  color: lightGrey.withOpacity(.1),
                  blurRadius: 12)
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: topColor ?? active,
                      height: 5,
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: '$title\n',
                    style: TextStyle(
                        fontSize: 16, color: isActive! ? active : lightGrey),
                  ),
                  TextSpan(
                    text: '$value',
                    style: TextStyle(
                        fontSize: 40, color: isActive! ? active : dark),
                  ),
                ]),
                textAlign: TextAlign.center,
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCardSmall extends StatelessWidget {
  const InfoCardSmall(
      {super.key, this.title, this.value, this.isActive = false, this.onTap});
  final String? title;
  final String? value;
  final bool? isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive! ? active : lightGrey,
              width: .5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: title ?? 'No Title',
                size: 24,
                weight: FontWeight.bold,
                color: isActive! ? active : lightGrey,
              ),
              CustomText(
                text: value ?? 'No Value',
                size: 24,
                weight: FontWeight.bold,
                color: isActive! ? active : lightGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
