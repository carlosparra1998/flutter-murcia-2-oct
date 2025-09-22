import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_murcia_2_oct/app/routes/route_helper.dart';
import 'package:flutter_murcia_2_oct/app/utils/global_resources.dart';
import 'package:flutter_murcia_2_oct/app/views/home/home_view.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

class LanguageProvider with ChangeNotifier {
  Locale? _selectedLanguage;

  bool _init = false;

  Locale? getLanguage() => _selectedLanguage;

  Future<void> initLanguage(BuildContext context) async {
    String? language = await getString('language_selected');

    if (language == null) {
      language = 'es';
      await _setLanguage(Locale(language));
      return;
    }
    _selectedLanguage = Locale(language);
    if (!_init) {
      Get.offAllNamed(RouterHelper.getHomeScreen());
    }
    _init = true;
  }

  Future<void> changeLanguage(String code) async {
    await _setLanguage(Locale(code));
  }

  Future<void> _setLanguage(Locale locale) async {
    await setString('language_selected', locale.languageCode);
    _selectedLanguage = locale;
    notifyListeners();
  }
}
