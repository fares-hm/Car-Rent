import 'package:flutter/material.dart';

class MyTheme{

  static Color getColorFromColorCode(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static const Color accent_color = Color.fromRGBO(58, 86, 187, 1.0);
  static const Color soft_accent_color = Color.fromRGBO(150, 162, 255, 1.0);

  static const  Color white = Color.fromRGBO(255,255,255, 1);
  static const Color light_grey = Color.fromRGBO(239,239,239, 1);
  static const Color dark_grey = Color.fromRGBO(112,112,112, 1);
  static const Color medium_grey = Color.fromRGBO(132,132,132, 1);
  static const Color red = Color.fromRGBO(255, 0, 0, 1.0);


  static const Color color_cyan = Color.fromRGBO(20, 171, 167, 1);



}