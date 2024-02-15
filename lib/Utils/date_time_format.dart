import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate({required DateTime date, required String formatType}) {
  final DateFormat formatter = DateFormat(formatType);
  return formatter.format(date);
}

Future<String?> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2015, 8),
    lastDate: DateTime(3000, 8),
  );
  if (picked != null) {
    String? formatedDate = formatDate(date: picked, formatType: "yyyy-MM-dd");
    return formatedDate;
  } else {
    return null;
  }
}
