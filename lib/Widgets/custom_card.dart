import 'package:flutter/material.dart';

import '../Commons/app_colors.dart';
import '../Commons/app_sizes.dart';

class CustomCard extends StatelessWidget {
  final Widget child;

  const CustomCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(AppSizes.cardCornerRadius),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, AppSizes.kDefaultPadding),
                blurRadius: AppSizes.kDefaultPadding,
                color: AppColors.lightGrey.withOpacity(0.6)),
          ],
          color: AppColors.white),
      child: child,
    );
  }
}
