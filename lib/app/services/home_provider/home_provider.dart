import 'package:flutter/material.dart';
import 'package:flutter_murcia_2_oct/app/enums/home_options.dart';
import 'package:flutter_murcia_2_oct/app/utils/route_helper.dart';
import 'package:get/get.dart';

class HomeProvider with ChangeNotifier {
  void onPressHomeOption(BuildContext context, HomeOption option) async {
    switch (option) {
      case HomeOption.dio:
      //await AuthRepository.login('user1', 'pass');
      case HomeOption.env:
        Get.toNamed(RouteHelper.envVariables);
      case HomeOption.internationalitation:
        Get.toNamed(RouteHelper.internationalitation);
      case HomeOption.extensions:
        Get.toNamed(RouteHelper.extensions);

    }
  }
}
