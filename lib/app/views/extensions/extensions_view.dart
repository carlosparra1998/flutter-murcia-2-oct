import 'package:flutter/material.dart';
import 'package:flutter_murcia_2_oct/app/widgets/my_app_bar.dart';

class ExtensionsView extends StatefulWidget {
  const ExtensionsView({super.key});

  @override
  State<ExtensionsView> createState() => _ExtensionsView();
}

class _ExtensionsView extends State<ExtensionsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 226, 226),
      appBar: myAppBar(context, 'Extensiones'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ex'),
            SizedBox(height: 20),
            Text('ex'),
            SizedBox(height: 20),
            Text('ex'),
            SizedBox(height: 20),
            Text('ex'),
          ],
        ),
      ),
    );
  }
}
