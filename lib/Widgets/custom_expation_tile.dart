import 'package:flutter/material.dart';

import '../Commons/app_colors.dart';

// ignore: must_be_immutable
class CustomExpansionPanel extends StatelessWidget {
  void Function(bool)? onExpansionChanged;
  bool initiallyExpanded = false;
  String title;
  List<Widget> children;
  TextStyle? titleStyle;
  Color? backgroundColor;
  Color? collapsedBackgroundColor;
  Widget? leading;
  bool? isIconShowing;
  int? index;
  CustomExpansionPanel(
      {super.key,
      required this.title,
      required this.onExpansionChanged,
      required this.initiallyExpanded,
      required this.children,
      this.titleStyle,
      this.backgroundColor,
      this.collapsedBackgroundColor,
      this.leading,
      this.isIconShowing = true,
      this.index});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        collapsedTextColor: AppColors.primaryIconColor,
        leading: leading,
        tilePadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
        childrenPadding: const EdgeInsets.only(left: 10),
        trailing: isIconShowing!
            ? const Icon(
                Icons.add_box,
                size: 18,
              )
            : const SizedBox(),
        // tilePadding: EdgeInsets.symmetric(horizontal: 0.w),
        collapsedShape: const ContinuousRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(0))),
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0))),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        backgroundColor: backgroundColor ?? AppColors.white,
        collapsedBackgroundColor: AppColors.white,
        expandedAlignment: Alignment.topLeft,
        collapsedIconColor: AppColors.primaryIconColor,
        textColor: AppColors.primaryDark,
        iconColor: AppColors.primaryDark,
        title: Transform.translate(
          offset: const Offset(-15, 0),
          child: Text(title, style: titleStyle ?? const TextStyle()),
        ),
        onExpansionChanged: onExpansionChanged,
        initiallyExpanded: initiallyExpanded,
        children: children);
  }
}
