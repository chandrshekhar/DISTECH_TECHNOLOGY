import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate({required DateTime date, required String formatType}) {
  final DateFormat formatter = DateFormat(formatType);
  return formatter.format(date);
}

Future<DateTime?> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2015, 8),
    lastDate: DateTime(3000, 8),
  );
  if (picked != null) {
    // String? formatedDate = formatDate(date: picked, formatType: "dd-MM-yyyy");
    return picked;
  } else {
    return null;
  }
}

String formatTime(String time24Hour) {
  // Parse the input time in 24-hour format
  DateTime parsedTime = DateFormat('HH:mm:ss').parse(time24Hour);

  // Format the time in 12-hour format with AM/PM
  String time12Hour = DateFormat('h:mm a').format(parsedTime);

  return time12Hour;
}

String formateDateddMMyyyy(DateTime date) {
  return formatDate(date: date, formatType: "dd-MM-yyyy");
}

String formateDateyyyyMMdd(String dateInDDMMYYYY) {
  // Create a DateFormat for "ddMMyyyy" format
  DateFormat inputFormat = DateFormat("dd-MM-yyyy");
  log("convert date -- > $dateInDDMMYYYY");
  // Parse the input date string
  DateTime dateTime = inputFormat.parse(dateInDDMMYYYY);

  // Create a DateFormat for "yyyy-MM-dd" format
  DateFormat outputFormat = DateFormat('yyyy-MM-dd');
  print("date outputformate--> $outputFormat");
  // Format the DateTime object to the desired output format
  String formattedDate = outputFormat.format(dateTime);

  return formattedDate;
}
