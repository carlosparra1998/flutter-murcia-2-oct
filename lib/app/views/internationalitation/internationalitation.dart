import 'package:flutter/material.dart';
import 'package:flutter_murcia_2_oct/app/services/language/language_provider.dart';
import 'package:flutter_murcia_2_oct/app/utils/general_utils.dart';
import 'package:flutter_murcia_2_oct/app/widgets/language_dropdown.dart';
import 'package:flutter_murcia_2_oct/app/widgets/my_app_bar.dart';
import 'package:flutter_murcia_2_oct/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class InternationalitationView extends StatefulWidget {
  const InternationalitationView({super.key});

  @override
  State<InternationalitationView> createState() => _InternationalitationView();
}

class _InternationalitationView extends State<InternationalitationView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (_, __, ___) => Scaffold(
        backgroundColor: Color.fromARGB(255, 226, 226, 226),
        appBar: myAppBar(context, 'Internacionalización'),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LanguageDropdown(),
                SizedBox(height: 20),
                Text(translate.hello),
                SizedBox(height: 20),
                Text(translate.goodBye),
                SizedBox(height: 20),
                Text('ex'),
                SizedBox(height: 20),
                Text('ex'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
