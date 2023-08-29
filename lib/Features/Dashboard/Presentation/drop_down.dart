// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

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
      height: 40,
      child: DropdownButtonFormField(
          dropdownColor: Colors.white,
          focusColor: Colors.black,
          hint: Text(
            widget.hintText ?? "10",
          ),
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(top: 4, bottom: 4, left: 18, right: 18),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.5),
                  borderRadius: BorderRadius.circular(5)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 0.5),
                  borderRadius: BorderRadius.circular(5)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
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
