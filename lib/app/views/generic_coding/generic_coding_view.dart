import 'package:flutter/material.dart';
import 'package:flutter_murcia_2_oct/app/widgets/my_app_bar.dart';

class GenericCodingView extends StatefulWidget {
  const GenericCodingView({super.key});

  @override
  State<GenericCodingView> createState() => _GenericCodingView();
}

class _GenericCodingView extends State<GenericCodingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 226, 226),
      appBar: myAppBar(context, 'Programación genérica'),
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
