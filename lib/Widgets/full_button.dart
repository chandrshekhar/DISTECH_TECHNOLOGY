import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_icons.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FullButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color bgColor;
  final bool? arrowIconVisible;

  const FullButton(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.bgColor = AppColors.primary,
      this.arrowIconVisible = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          elevation: 0,
          minimumSize: Size.fromHeight(50.h)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: AppColors.white, fontWeight: FontWeight.w500),
          ),
          arrowIconVisible!
              ? SizedBox(
                  width: AppSizes.kDefaultPadding,
                )
              : const SizedBox(),
          arrowIconVisible!
              ? Image.asset(
                  AppIcons.forwardArrowIcon,
                  width: 24.w,
                  height: 24.h,
                  color: AppColors.white,
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
