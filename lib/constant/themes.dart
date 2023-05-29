import 'package:flutter/material.dart';

List<ThemeData> themeArray = [
  ThemeData(
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange).copyWith(
      secondary: Colors.yellow,
    ),
  ),
  ThemeData(
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(
      secondary: Colors.greenAccent,
    ),
  ),
  ThemeData(
    colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blueGrey, brightness: Brightness.dark)
        .copyWith(
      secondary: const Color.fromARGB(255, 14, 148, 137),
    ),
  ),
];

List<Color> colorList = [Colors.orange, Colors.green, Colors.grey.shade500];
