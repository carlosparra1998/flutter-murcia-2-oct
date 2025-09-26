import 'package:flutter/widgets.dart';

class LanguageProvider with ChangeNotifier{
  Locale locale = Locale('es');

  void changeLanguage(Locale loc){
    locale = loc;
    notifyListeners();
  }
}