import 'package:distech_technology/Commons/app_colors.dart';
import 'package:flutter/material.dart';

class HeaderListWidget extends StatelessWidget {
  const HeaderListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'F.L.',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.darkGrey.withOpacity(0.8),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Text(
                      'T. L.',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.darkGrey.withOpacity(0.8),
                          fontWeight: FontWeight.w500),
                    )),
                Expanded(
                  flex: 2,
                  child: Text(
                    'From No.',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.darkGrey.withOpacity(0.8),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    '     To No.',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.darkGrey.withOpacity(0.8),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  'Add',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.darkGrey.withOpacity(0.8),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
         
          );
  }
}