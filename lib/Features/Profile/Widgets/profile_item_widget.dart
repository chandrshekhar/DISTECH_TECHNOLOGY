import 'package:flutter/material.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_sizes.dart';

class ProfileItemWidget extends StatelessWidget {
  final String title;
  final String value;

  const ProfileItemWidget({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColors.darkGrey.withOpacity(0.8)),
        ),
        const SizedBox(
          height: AppSizes.kDefaultPadding / 3,
        ),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: AppSizes.kDefaultPadding,
        ),
      ],
    );
  }
}
