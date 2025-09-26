import 'package:flutter/widgets.dart';

class LanguageProvider with ChangeNotifier{
  Locale _locale = Locale('es');
  Locale get locale => _locale;

  void changeLanguage(Locale loc){
    _locale = loc;
    notifyListeners();
  }
}