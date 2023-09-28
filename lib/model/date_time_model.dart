import 'package:intl/intl.dart';

String getDateTime() {
  final now = DateTime.now();
  final formatter = DateFormat('MMM, d');
  String formattedDate = formatter.format(now);
  return formattedDate;
}
