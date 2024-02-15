import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:flutter/material.dart';

class ScannerCardWidget extends StatelessWidget {
  ScannerCardWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      this.icon,
      this.onTap});

  final String title;
  final String subTitle;
  void Function()? onTap;
  String? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.cardCornerRadius),
      margin: const EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius / 2),
          border: Border.all(color: AppColors.bg)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: '$title ',
                    style: const TextStyle(
                      fontSize: 16,
                    )),
                TextSpan(
                  text: subTitle.isNotEmpty ? "($subTitle)" : '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Image.asset(
              icon ?? "assets/icons/barcode-scanner.png",
              width: 25,
              height: 25,
            ),
          ),
        ],
      ),
    );
  }
}
