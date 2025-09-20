import 'package:flutter/material.dart';
import 'package:flutter_murcia_2_oct/app/enums/home_options.dart';
import 'package:flutter_murcia_2_oct/app/services/home_provider/home_provider.dart';
import 'package:flutter_murcia_2_oct/app/views/home/widgets/home_option.dart';
import 'package:flutter_murcia_2_oct/app/widgets/my_app_bar.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 226, 226),
      appBar: myAppBar(context, 'Bienvenidos a Flutter Murcia'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon.png',
              fit: BoxFit.contain,
              width: 150,
              height: 150,
            ),
            SizedBox(height: 50),
            ...List.generate(HomeOption.values.length, (ix) {
              HomeOption option = HomeOption.values[ix];
              return HomeOptionWidget(
                title: option.title,
                onTap: () {
                  context.read<HomeProvider>().onPressHomeOption(
                    context,
                    option,
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
