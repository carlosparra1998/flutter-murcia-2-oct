
import 'package:flutter_murcia_2_oct/app/views/env_variables/env_variables_view.dart';
import 'package:flutter_murcia_2_oct/app/views/extensions/extensions_view.dart';
import 'package:flutter_murcia_2_oct/app/views/home/home_view.dart';
import 'package:flutter_murcia_2_oct/app/views/internationalitation/internationalitation.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class RouteHelper {

  static String home = "/home"; 
  static String envVariables = "/home/env-var"; 
  static String internationalitation = "/home/internationalitation"; 
  static String extensions = "/home/extensions";

  static List<GetPage> routes = [
    GetPage(name: home, page: () => HomeView()),
    GetPage(name: envVariables, page: () => EnvVariablesView()),
    GetPage(name: internationalitation, page: () => InternationalitationView()),
    GetPage(name: extensions, page: () => ExtensionsView()),
  ];


}