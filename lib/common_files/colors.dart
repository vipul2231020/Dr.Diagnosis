import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color dark = Color.fromARGB(255, 07, 15, 97);
  static Color mildBlack = Colors.black.withOpacity(.6);
  static Color lightBlue = Color.fromARGB(255, 202, 214, 255);



  static const TextStyle titleMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    letterSpacing: 1,
  );
}