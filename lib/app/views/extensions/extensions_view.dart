import 'package:flutter/material.dart';
import 'package:flutter_murcia_2_oct/app/extensions/date_time.dart';
import 'package:flutter_murcia_2_oct/app/extensions/num.dart';
import 'package:flutter_murcia_2_oct/app/widgets/my_app_bar.dart';

class ExtensionsView extends StatefulWidget {
  const ExtensionsView({super.key});

  @override
  State<ExtensionsView> createState() => _ExtensionsView();
}

class _ExtensionsView extends State<ExtensionsView> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    double bill = 3.3434;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 226, 226),
      appBar: myAppBar(context, 'Extensiones'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(now.toNaturalLanguage()),
            SizedBox(height: 20),
            Text(bill.toMoney()),
          ],
        ),
      ),
    );
  }
}
