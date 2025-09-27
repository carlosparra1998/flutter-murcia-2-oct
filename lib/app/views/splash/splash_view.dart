import 'package:flutter/material.dart';
import 'package:flutter_murcia_2_oct/app/services/language_provider/language_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<LanguageProvider>().initProvider();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 226, 226),

      body: Center(
        child: Image.asset(
          'assets/images/icon.png',
          fit: BoxFit.contain,
          width: 120,
          height: 120,
        ),
      ),
    );
  }
}
