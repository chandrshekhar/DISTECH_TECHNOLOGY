// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:distech_technology/Commons/app_colors.dart';
import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDropDown extends StatefulWidget {
  ValueChanged onChanged;
  List<dynamic> list;
  String? hintText;
  Color? bgColor;
  TextStyle? hintTextStyle;
  AppDropDown(
      {Key? key,
      required this.onChanged,
      required this.list,
      this.hintText,
      this.hintTextStyle,
      this.bgColor})
      : super(key: key);
  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.w,
      child: DropdownButtonFormField(
          dropdownColor: Colors.white,
          focusColor: Colors.black,
          hint: Text(
            widget.hintText ?? "10",
          ),
          decoration: InputDecoration(
              fillColor: AppColors.white,
              filled: true,
              contentPadding: EdgeInsets.only(
                  top: 4.h, bottom: 4.h, left: 12.w, right: 12.w),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.bg, width: 0.8),
                  borderRadius:
                      BorderRadius.circular(AppSizes.cardCornerRadius / 2)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.bg, width: 0.8),
                  borderRadius:
                      BorderRadius.circular(AppSizes.cardCornerRadius / 2)),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppSizes.cardCornerRadius / 2),
              )),
          items: widget.list.map((e) {
            return DropdownMenuItem(
                value: e,
                child: Text(
                  e.toString(),
                ));
          }).toList(),
          onChanged: widget.onChanged),
    );
  }
}



  //  height: AppSizes.buttonHeight + 4,
  //                       decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(
  //                               AppSizes.cardCornerRadius / 2),
  //                           border: Border.all(color: AppColors.bg)),