
import 'package:flutter_murcia_2_oct/app/views/env_variables/env_variables_view.dart';
import 'package:flutter_murcia_2_oct/app/views/extensions/extensions_view.dart';
import 'package:flutter_murcia_2_oct/app/views/generic_coding/generic_coding_view.dart';
import 'package:flutter_murcia_2_oct/app/views/home/home_view.dart';
import 'package:flutter_murcia_2_oct/app/views/internationalitation/internationalitation.dart';
import 'package:flutter_murcia_2_oct/app/views/splash/splash_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class RouteHelper {
  static String splash = "/";
  static String home = "/home"; 
  static String envVariables = "/home/env-var"; 
  static String genericCoding = "/home/generic-coding"; 
  static String internationalitation = "/home/internationalitation"; 
  static String extensions = "/home/extensions";

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: home, page: () => HomeView()),
    GetPage(name: envVariables, page: () => EnvVariablesView()),
    GetPage(name: internationalitation, page: () => InternationalitationView()),
    GetPage(name: extensions, page: () => ExtensionsView()),
    GetPage(name: genericCoding, page: () => GenericCodingView()),
  ];


}