import 'package:flutter/material.dart';

import '../constantns/app_colors.dart';



class AppTheme {
  static Map<int, Color> colorCodes = {
    50: const Color.fromRGBO(96, 64, 143, .1),
    100: const Color.fromRGBO(96, 64, 143, .2),
    200: const Color.fromRGBO(96, 64, 143, .3),
    300: const Color.fromRGBO(96, 64, 143, .4),
    400: const Color.fromRGBO(96, 64, 143, .5),
    500: const Color.fromRGBO(96, 64, 143, .6),
    600: const Color.fromRGBO(96, 64, 143, .7),
    700: const Color.fromRGBO(96, 64, 143, .8),
    800: const Color.fromRGBO(96, 64, 143, .9),
    900: const Color.fromRGBO(96, 64, 143, 1),
  };
  static MaterialColor customColor = MaterialColor(0xFF60408F, colorCodes);

  static ThemeData lightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: "Verdana",
      primarySwatch: customColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      primaryColor: AppColors.textColor,
      canvasColor: AppColors.canvasColor,
      hintColor: AppColors.red,
      cardColor: AppColors.containerColor,
      dividerColor: AppColors.dividerColor,
      splashColor: customColor.shade200.withOpacity(.05),
      appBarTheme:  AppBarTheme(
        elevation: 0.0,
        color: AppColors.appBarColor,
        iconTheme:  IconThemeData(
          color: AppColors.iconColor,
        ),
        titleTextStyle: TextStyle(
          color: AppColors.iconColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: "Verdana",
        ),
        centerTitle: true,
      ),
    );
  }
  static ThemeData darkTheme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.darkBackgroundColor,
      fontFamily: "Verdana",
      primarySwatch: customColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      primaryColor: AppColors.appBarColor,
      hintColor: AppColors.red,
      canvasColor: Colors.black,
      cardColor: AppColors.darkContainerColor,
      dividerColor: AppColors.darkContainerColor,
      splashColor: Colors.grey.withOpacity(.01),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle:
        TextStyle(color: Colors.white30, fontWeight: FontWeight.w500),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: AppColors.mainColor,
          ),
        ),
      ),
      appBarTheme:  const AppBarTheme(
        elevation: 0.0,
        color: AppColors.darkBackgroundColor,
        iconTheme: IconThemeData(
          color: AppColors.appBarColor,
        ),
        titleTextStyle: TextStyle(
          color: AppColors.appBarColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: "Verdana",
        ),
        centerTitle: true,
      ),
    );
  }
}