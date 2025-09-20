import 'package:flutter/material.dart';

AppBar myAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/images/icon.png',
          fit: BoxFit.contain,
          width: 40,
          height: 40,
        ),
        Text(title),
        SizedBox(),
      ],
    ),
  );
}
