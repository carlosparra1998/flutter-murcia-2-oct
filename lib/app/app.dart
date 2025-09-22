import 'package:flutter/material.dart';
import 'package:flutter_murcia_2_oct/app/services/home_provider/home_provider.dart';
import 'package:flutter_murcia_2_oct/app/services/language_provider/language_provider.dart';
import 'package:flutter_murcia_2_oct/app/utils/global_resources.dart';
import 'package:flutter_murcia_2_oct/app/views/home/home_view.dart';
import 'package:flutter_murcia_2_oct/app/views/splash/splash_view.dart';
import 'package:flutter_murcia_2_oct/l10n/app_localizations.dart';
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
        builder: (_, provider, __) => MaterialApp(
          title: 'Flutter Murcia',
          navigatorKey: globalKey,
          locale: provider.getLanguage(),
          localizationsDelegates: [...AppLocalizations.localizationsDelegates],
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          ),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
