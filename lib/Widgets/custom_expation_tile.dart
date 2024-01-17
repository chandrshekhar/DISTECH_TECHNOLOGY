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
  CustomExpansionPanel(
      {super.key,
      required this.title,
      required this.onExpansionChanged,
      required this.initiallyExpanded,
      required this.children,
      this.titleStyle,
      this.backgroundColor,
      this.collapsedBackgroundColor,
      this.leading});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        collapsedTextColor: AppColors.primary,
        leading: leading,
        childrenPadding: EdgeInsets.zero,
        trailing: const Icon(
          Icons.add_box,
          size: 18,
        ),
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
        collapsedIconColor: AppColors.primary,
        iconColor: AppColors.primary,
        title: Transform.translate(
          offset: const Offset(-15, 0),
          child: Text(title, style: titleStyle ?? const TextStyle()),
        ),
        onExpansionChanged: onExpansionChanged,
        initiallyExpanded: initiallyExpanded,
        children: children);
  }
}
