import 'package:flutter/material.dart';
import 'package:flutter_murcia_2_oct/app/enums/home_options.dart';
import 'package:flutter_murcia_2_oct/app/repositories/auth/auth_repository.dart';
import 'package:flutter_murcia_2_oct/app/routes/route_helper.dart';
import 'package:flutter_murcia_2_oct/app/views/extensions/extensions_view.dart';
import 'package:flutter_murcia_2_oct/app/views/internationalitation/internationalitation_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeProvider with ChangeNotifier {
  void onPressHomeOption(BuildContext context, HomeOption option) async {
    switch (option) {
      case HomeOption.dio:
        final res = await AuthRepository.login('user1', 'pass');
        print(res);
      case HomeOption.env:
        Get.toNamed(
          RouterHelper.getEnvScreen(),
          arguments: {"example": "Hello view!"},
        );

      case HomeOption.internationalitation:
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const InternationalitationView(),
          ),
        );
      case HomeOption.extensions:
        Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (context) => const ExtensionsView()),
        );
    }
  }
}
