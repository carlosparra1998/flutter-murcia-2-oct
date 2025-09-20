import 'package:flutter/material.dart';
import 'package:flutter_murcia_2_oct/app/widgets/my_app_bar.dart';

class EnvVariablesView extends StatefulWidget {
  const EnvVariablesView({super.key});

  @override
  State<EnvVariablesView> createState() => _EnvVariablesViewState();
}

class _EnvVariablesViewState extends State<EnvVariablesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 226, 226),
      appBar: myAppBar(context, 'Variables de entorno'),
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
