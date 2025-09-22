import 'package:flutter_murcia_2_oct/app/views/env_variables/env_variables_view.dart';
import 'package:flutter_murcia_2_oct/app/views/home/home_view.dart';
import 'package:flutter_murcia_2_oct/app/views/splash/splash_view.dart';
import 'package:get/get.dart';

class RouterHelper {
  static const String _splashScreen = "/";
  static const String _homeScreen = "/home";
  static const String _envScreen = "/home/env";

  static String getSplashScreen() => _splashScreen;
  static String getHomeScreen() => _homeScreen;
  static String getEnvScreen() => _envScreen;

  static List<GetPage> routes = [
    GetPage(name: _splashScreen, page: () => const SplashScreen()),
    GetPage(name: _homeScreen, page: () => const HomeView()),
    GetPage(name: _envScreen, page: () => EnvVariablesView()),
  ];
}
