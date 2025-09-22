import 'package:intl/intl.dart';

extension NumExtension on num {
  double get getCurrencyFormat {
    return double.tryParse(toStringAsFixed(2)) ?? 0.0;
  }
}
