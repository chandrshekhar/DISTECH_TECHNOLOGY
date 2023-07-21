import 'package:flutter/material.dart';

import '../Commons/app_colors.dart';

class CustomDivider extends StatelessWidget {
  final bool? isVertical;

  const CustomDivider({Key? key, this.isVertical = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isVertical!
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: 1,
            color: AppColors.bg,
          )
        : Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: AppColors.bg,
          );
  }
}
