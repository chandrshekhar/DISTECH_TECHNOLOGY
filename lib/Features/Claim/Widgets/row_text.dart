import 'package:distech_technology/Commons/app_sizes.dart';
import 'package:flutter/material.dart';

class RowTextCard extends StatelessWidget {
  String? title1;
  String? title2;
  String? val1;
  String? val2;
  RowTextCard({super.key, this.title1, this.title2, this.val1, this.val2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppSizes.kDefaultPadding / 10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: title1,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: val1,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: title2,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: val2,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
