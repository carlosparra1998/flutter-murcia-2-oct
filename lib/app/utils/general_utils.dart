  import 'package:flutter/material.dart';
import 'package:flutter_murcia_2_oct/l10n/app_localizations.dart';

bool isNotPrimitiveData<T>() =>
      T != Map &&
      T != String &&
      T != num &&
      T != int &&
      T != double &&
      T != bool &&
      (T != List<String>) &&
      (T != List<num>) &&
      (T != List<int>) &&
      (T != List<double>) &&
      (T != List<bool>);


GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

BuildContext get globalContext => navigatorKey.currentContext!;

AppLocalizations get translate => AppLocalizations.of(globalContext)!;