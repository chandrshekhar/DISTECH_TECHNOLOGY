import 'package:intl/intl.dart';

String formatDate({required DateTime date, required String formatType}) {
  final DateFormat formatter = DateFormat(formatType);
  return formatter.format(date);
}