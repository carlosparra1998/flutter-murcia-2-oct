import 'package:flutter/material.dart';
import 'package:flutter_murcia_2_oct/app/enums/home_options.dart';
import 'package:flutter_murcia_2_oct/app/views/env_variables/env_variables_view.dart';
import 'package:flutter_murcia_2_oct/app/views/extensions/extensions_view.dart';
import 'package:flutter_murcia_2_oct/app/views/internationalitation/internationalitation.dart';

class HomeProvider with ChangeNotifier {
  void onPressHomeOption(BuildContext context, HomeOption option) async{
    switch (option) {
      case HomeOption.dio:
        // TODO: await AuthRepository.login('user1', 'pass');
      case HomeOption.env:
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const EnvVariablesView(),
          ),
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
