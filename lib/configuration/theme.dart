import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';

class AppTheme{


  static ThemeData light(){

    return ThemeData(
        useMaterial3: true,
        fontFamily: Constants.defaultFontFamily,
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: AppColors.primary,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: Constants.defaultFontFamily,
                fontSize: 22
            ),
            iconTheme: const IconThemeData(
                color: Colors.white
            )
        ),
        colorScheme: const ColorScheme.light(
            secondary: AppColors.secondary,
            primary: AppColors.primary
        ),
        textTheme: TextTheme(
            headlineLarge: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                fontFamily: Constants.defaultFontFamily
            )
        )

    );
  }

  static ThemeData dark(){

    return ThemeData(
        useMaterial3: true,
        fontFamily: "Poppins",
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.secondary,
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: AppColors.primary,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 22
            ),
            iconTheme: IconThemeData(
                color: Colors.white
            )
        ),
        colorScheme: const ColorScheme.dark(
            secondary: AppColors.secondary,
            primary: AppColors.primary
        ),
        textTheme: const TextTheme(
            headlineLarge: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
            )
        )

    );
  }
}