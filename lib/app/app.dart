import 'package:flutter/material.dart';
import 'package:flutter_murcia_2_oct/app/services/home_provider/home_provider.dart';
import 'package:flutter_murcia_2_oct/app/services/language_provider/language_provider.dart';
import 'package:flutter_murcia_2_oct/app/utils/general_utils.dart';
import 'package:flutter_murcia_2_oct/app/utils/route_helper.dart';
import 'package:flutter_murcia_2_oct/l10n/L10N.dart';
import 'package:flutter_murcia_2_oct/l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: Consumer<LanguageProvider>(
        builder:
            (_, provider, __) => GetMaterialApp(
              title: 'Flutter Murcia',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
              ),
              navigatorKey: navigatorKey,
              locale: provider.locale,
              supportedLocales: L10n.all,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              getPages: RouteHelper.routes,
              initialRoute: RouteHelper.splash,
            ),
      ),
    );
  }
}
