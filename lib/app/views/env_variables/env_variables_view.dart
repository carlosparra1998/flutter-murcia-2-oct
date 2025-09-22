import 'package:flutter/material.dart';
import 'package:flutter_murcia_2_oct/app/utils/env.dart';
import 'package:flutter_murcia_2_oct/app/widgets/my_app_bar.dart';
import 'package:get/get.dart';

class EnvVariablesView extends StatefulWidget {
  final String comment;
  EnvVariablesView({super.key}) : comment = Get.arguments['example'];

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
            Text(widget.comment),
            SizedBox(height: 20),
            Text(Env.API_URL ?? ''),
            SizedBox(height: 20),
            Text(Env.PASSWORD ?? ''),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
