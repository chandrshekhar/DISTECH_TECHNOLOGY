import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../Commons/app_colors.dart';
import '../Commons/app_sizes.dart';

class CustomChip extends StatelessWidget {
  bool? isSelected;
  final String label;
  final VoidCallback onTap;

  CustomChip(
      {Key? key,
      this.isSelected = false,
      required this.label,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: AppSizes.buttonHeight,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: isSelected! ? AppColors.primary : AppColors.primaryBg,
            borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius / 2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSelected!
                ? const Icon(
                    EvaIcons.checkmark,
                    size: 20,
                    color: AppColors.white,
                  )
                : const SizedBox(),
            isSelected!
                ? const SizedBox(
                    width: AppSizes.kDefaultPadding / 4,
                  )
                : const SizedBox(),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: isSelected! ? AppColors.white : AppColors.black),
            )
          ],
        ),
      ),
    );
  }
}
