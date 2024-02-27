import 'package:distech_technology/Utils/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBillsController extends GetxController {
  RxString fromDateController = ''.obs;
  RxString toDateController = ''.obs;
  Rx<String> startDate =
      formatDate(date: DateTime.now(), formatType: "yyyy-MM-dd").obs;
  Rx<String> endDate =
      formatDate(date: DateTime.now(), formatType: "yyyy-MM-dd").obs;
  final textEditController = TextEditingController().obs;

  Future<String?> selectDate(BuildContext context) async {
    final picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2025),
        initialDateRange:
            DateTimeRange(start: DateTime.now(), end: DateTime.now()));
    if (picked != null) {
      startDate.value =
          formatDate(date: picked.start, formatType: "yyyy-MM-dd");
      endDate.value = formatDate(date: picked.end, formatType: "yyyy-MM-dd");
      return "$startDate - $endDate";
    } else {
      return null;
    }
  }
}
