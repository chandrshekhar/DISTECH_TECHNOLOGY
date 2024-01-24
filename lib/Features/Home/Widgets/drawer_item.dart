import 'package:flutter/material.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_sizes.dart';

class DrawerItem extends StatelessWidget {
  final String icon;
  final Color bgColor;
  final String label;
  void Function()? onTap;

  DrawerItem(
      {Key? key,
      required this.icon,
      required this.bgColor,
      required this.label,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: bgColor,
        padding: EdgeInsets.all(AppSizes.kDefaultPadding / 2),
        child: Row(
          children: [
            Image.asset(
              icon,
              color: AppColors.primary,
              width: 20,
              height: 20,
            ),
            SizedBox(
              width: AppSizes.kDefaultPadding,
            ),
            Expanded(
                child: Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.darkGrey.withOpacity(0.8),
                  fontWeight: FontWeight.w500),
            ))
          ],
        ),
      ),
    );
  }
}
