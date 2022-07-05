// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme ? Colors.black : Colors.white, //Colors.grey[100],
      primarySwatch: Colors.blue,
      primaryColor: isDarkTheme ? Colors.black : Colors.grey[200],
      // ignore: deprecated_member_use
      accentColor: Colors.blue,
      backgroundColor: isDarkTheme ? Colors.grey.shade700 : Colors.white,
      indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      // ignore: deprecated_member_use
      buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
      hintColor: isDarkTheme ? Colors.grey.shade300 : Colors.grey.shade800,
      // highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      // ignore: deprecated_member_use
      textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
      fontFamily: "Popins",
      // primaryColor: Color.fromRGBO(7, 190, 200, 1),

      textTheme: TextTheme(
        headline1: ThemeData.light().textTheme.headline1.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 38.0,
          fontFamily: "Popins",
        ),
        headline5: ThemeData.light().textTheme.headline1.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 17.0,
          fontFamily: "Popins",
        ),
        headline3: ThemeData.light().textTheme.headline3.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 20.0,
          fontFamily: "Popins",
        ),
      ),
    );
  }
}
