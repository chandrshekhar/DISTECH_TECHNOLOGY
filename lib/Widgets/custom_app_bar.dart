import 'package:distech_technology/Commons/app_icons.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../Commons/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool? autoImplyLeading;
  final IconData? leadingIcon;
  final VoidCallback? leadingIconPressed;

  const CustomAppBar({
    Key? key,
    this.title = '',
    this.actions,
    this.autoImplyLeading = true,
    this.leadingIcon = EvaIcons.arrowIosBack,
    this.leadingIconPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: autoImplyLeading!,
      actions: actions,
      leading: autoImplyLeading!
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Image.asset(
                AppIcons.arrowBack,
                color: AppColors.white,
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ))
          // IconButton(
          //         icon: const Icon(
          //           EvaIcons.arrowBackOutline,
          //           color: AppColors.white,
          //           size: 30,
          //         ),
          //         onPressed: () {
          //           Navigator.pop(context);
          //         },
          //       )
          : IconButton(
              onPressed: leadingIconPressed,
              icon: Icon(
                leadingIcon,
                size: 30,
                color: AppColors.white,
              ),
            ),
      title: Text(
        title!,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
