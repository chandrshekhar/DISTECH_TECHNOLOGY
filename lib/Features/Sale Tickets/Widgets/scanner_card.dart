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
      padding: EdgeInsets.all(AppSizes.cardCornerRadius / 2),
      margin: const EdgeInsets.only(bottom: 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius / 2),
          border: Border.all(color: AppColors.bg)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: '$title  \n',
                    style: const TextStyle(
                      fontSize: 14,
                    )),
                TextSpan(
                  text: subTitle.isNotEmpty ? "($subTitle)" : '',
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 14),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Image.asset(
              icon ?? "assets/icons/barcode-scanner.png",
              width: 20,
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}
