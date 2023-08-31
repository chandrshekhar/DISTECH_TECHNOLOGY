import 'package:distech_technology/Controller/Timer%20Controller/timer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final timerController = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text('Last Return Time',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.secondary.withOpacity(0.9),
                    )),
            SizedBox(
              height: 2.h,
            ),
            Text(
              "07:00 PM",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp),
            ),
          ],
        ),
        Column(
          children: [
            Image.asset(
              AppIcons.timerIcon,
              width: 40.w,
              height: 40.h,
            ),
            Obx(() => Text(timerController.countdown.value,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp)))
          ],
        ),
        SizedBox(
          height: 1.h,
        ),
        Column(
          children: [
            Text(
              'Draw Time',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.darkGrey.withOpacity(0.9),
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp),
            ),
            SizedBox(
              height: AppSizes.kDefaultPadding / 3,
            ),
            Text(
              '07:35 PM',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp),
            ),
          ],
        )
      ],
    ));
  }
}
