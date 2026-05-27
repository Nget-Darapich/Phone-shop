import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(

    brightness: Brightness.light,

    scaffoldBackgroundColor:
        AppColors.slate50,

    fontFamily: 'Poppins',

    colorScheme: const ColorScheme.light(
      primary: AppColors.blue500,
      secondary: AppColors.cyan400,
    ),
  );



  static ThemeData darkTheme = ThemeData(

    brightness: Brightness.dark,

    scaffoldBackgroundColor:
        AppColors.slate950,

    fontFamily: 'Poppins',

    colorScheme: const ColorScheme.dark(
      primary: AppColors.blue500,
      secondary: AppColors.cyan400,
    ),
  );
}