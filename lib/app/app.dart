import 'package:flutter/material.dart';
import 'package:flutter_murcia_2_oct/app/services/home_provider/home_provider.dart';
import 'package:flutter_murcia_2_oct/app/utils/route_helper.dart';
import 'package:flutter_murcia_2_oct/app/views/home/home_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => HomeProvider())],
      child: GetMaterialApp(
        title: 'Flutter Murcia',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: const HomeView(),
        getPages: RouteHelper.routes,
        initialRoute: RouteHelper.home,
      ),
    );
  }
}
