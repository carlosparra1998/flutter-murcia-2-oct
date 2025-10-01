import 'package:flutter/widgets.dart';
import 'package:flutter_murcia_2_oct/app/utils/route_helper.dart';
import 'package:get/get.dart';

class LanguageProvider with ChangeNotifier{
  Locale? _locale;

  Locale? get locale => _locale;

  void initProvider(){
    _locale = Locale('es');
    Get.offAllNamed(RouteHelper.home);
  }

  void changeLanguage(Locale newLoc){
    _locale = newLoc;
    notifyListeners();
  }
}