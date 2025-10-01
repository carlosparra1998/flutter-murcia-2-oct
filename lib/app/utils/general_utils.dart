import 'package:flutter/material.dart';
import 'package:flutter_murcia_2_oct/l10n/app_localizations.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

BuildContext get globalContext => navigatorKey.currentContext!;

AppLocalizations get translate => AppLocalizations.of(globalContext)!;