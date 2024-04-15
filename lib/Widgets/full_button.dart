import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_icons.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
          minimumSize: const Size.fromHeight(50)),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppColors.white, fontWeight: FontWeight.w500),
            ).tr(),
            arrowIconVisible!
                ? SizedBox(
                    width: AppSizes.kDefaultPadding,
                  )
                : const SizedBox(),
            arrowIconVisible!
                ? Image.asset(
                    AppIcons.forwardArrowIcon,
                    width: 24,
                    height: 24,
                    color: AppColors.white,
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
