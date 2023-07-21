import 'package:distech_technology/Features/Home/Models/drawer_item_model.dart';
import 'package:flutter/material.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_sizes.dart';

class DrawerItem extends StatelessWidget {
  final DrawerItemModel drawerItemModel;
  final Color bgColor;

  const DrawerItem({Key? key, required this.drawerItemModel, required this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      padding: const EdgeInsets.all(AppSizes.kDefaultPadding),
      child: Row(
        children: [
          Image.asset(
            drawerItemModel.icon,
            width: 20,
            height: 20,
          ),
          const SizedBox(
            width: AppSizes.kDefaultPadding,
          ),
          Expanded(
              child: Text(
            drawerItemModel.label,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.darkGrey.withOpacity(0.8),
                fontWeight: FontWeight.w500),
          ))
        ],
      ),
    );
  }
}
