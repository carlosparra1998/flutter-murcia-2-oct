// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get spanish => 'Spanish';

  @override
  String get english => 'English';

  @override
  String get hello => 'Hello';

  @override
  String totalValue(int value) {
    return 'The total value is $value euros';
  }
}
