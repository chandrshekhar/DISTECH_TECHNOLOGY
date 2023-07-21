import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../Commons/app_colors.dart';
import '../../../Commons/app_icons.dart';
import '../../../Commons/app_sizes.dart';
import '../../../Widgets/custom_card.dart';

class TimerCardWidget extends StatefulWidget {
  const TimerCardWidget({Key? key}) : super(key: key);

  @override
  State<TimerCardWidget> createState() => _TimerCardWidgetState();
}

class _TimerCardWidgetState extends State<TimerCardWidget> {

  String formattedTime = DateFormat('hh:mm a').format(DateTime.now());
  String hour = DateFormat('a').format(DateTime.now());
  late Timer _timer;

  @override
  void initState() {
    //update timer in every seconds e.g. 1000 milliseconds
    _timer = Timer.periodic(
        const Duration(milliseconds: 1000), (timer) => _update());
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _update() {
    setState(() {
      formattedTime = DateFormat('hh:mm a').format(DateTime.now());
      hour = DateFormat('a').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Current Time',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(
                      color: AppColors.darkGrey.withOpacity(0.9),
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: AppSizes.kDefaultPadding / 3,
                ),
                Text(
                  formattedTime,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  AppIcons.timerIcon,
                  width: 40,
                  height: 40,
                ),
                Text('10:10',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            Column(
              children: [
                Text(
                  'Last Return Time',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(
                      color: AppColors.secondary.withOpacity(0.9),
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: AppSizes.kDefaultPadding / 3,
                ),
                Text(
                  '07:55 PM',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        ));
  }
}
