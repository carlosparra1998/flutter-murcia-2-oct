import 'package:intl/intl.dart';

extension DatetimeExt on DateTime {
  String get fromDatetime {
    return DateFormat('yyyy/MM/dd').format(this);
  }
}
