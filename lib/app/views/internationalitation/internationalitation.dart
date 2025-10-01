import 'package:flutter/material.dart';
import 'package:flutter_murcia_2_oct/app/utils/general_utils.dart';
import 'package:flutter_murcia_2_oct/app/widgets/language_dropdown.dart';
import 'package:flutter_murcia_2_oct/app/widgets/my_app_bar.dart';

class InternationalitationView extends StatefulWidget {
  const InternationalitationView({super.key});

  @override
  State<InternationalitationView> createState() => _InternationalitationView();
}

class _InternationalitationView extends State<InternationalitationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 226, 226),
      appBar: myAppBar(context, translate.internationalitation),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LanguageDropdown(),
              SizedBox(height: 20),
              Text(translate.spanish),
              SizedBox(height: 20),
              Text(translate.english),
              SizedBox(height: 20),
              Text(translate.helloWorld),
              SizedBox(height: 20),
              Text(translate.internationalitation),
            ],
          ),
        ),
      ),
    );
  }
}
