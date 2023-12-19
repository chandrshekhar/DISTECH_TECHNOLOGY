import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/date_time_format.dart';

class MyClaimController extends GetxController {
  RxString dateFormat = ''.obs;

  final myClaimSearcController = TextEditingController().obs;

  //void selectDate() {}
  DateTime selectedDate = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(3000, 8),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      var formatedDate = formatDate(date: picked, formatType: "yyyy-MM-dd");
      dateFormat.value = formatedDate;
    }
  }

  List selectDropDownLimit = [10, 25, 50, 100, 500];
}
