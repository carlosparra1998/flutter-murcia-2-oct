import 'package:flutter/material.dart';
import 'package:flutter_murcia_2_oct/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

BuildContext get globalContext => globalKey.currentState!.context;

AppLocalizations get translate => AppLocalizations.of(globalContext)!;

Future<String?> getString(String code) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? text = prefs.getString(code);
  return (text?.isEmpty ?? false) ? null : text;
}

Future<void> setString(String code, String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(code, value);
}