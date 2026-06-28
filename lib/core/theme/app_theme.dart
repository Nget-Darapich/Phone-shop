import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.slate50,
    fontFamily: 'Poppins',
    primaryColor: AppColors.blue500,
    cardColor: Colors.white,
    canvasColor: Colors.white,
    dividerColor: AppColors.inactiveLight,
    iconTheme: const IconThemeData(color: AppColors.textDark),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textDark),
      titleTextStyle: TextStyle(
        color: AppColors.textDark,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textDark),
      bodyMedium: TextStyle(color: AppColors.textDark),
      bodySmall: TextStyle(color: AppColors.textDark),
      titleLarge: TextStyle(color: AppColors.textDark),
      titleMedium: TextStyle(color: AppColors.textDark),
      headlineMedium: TextStyle(color: AppColors.textDark),
      headlineSmall: TextStyle(color: AppColors.textDark),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.blue500,
      secondary: AppColors.cyan400,
      surface: AppColors.slate50,
      onSurface: AppColors.textDark,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.slate950,
    fontFamily: 'Poppins',
    primaryColor: AppColors.blue500,
    cardColor: AppColors.slate900,
    canvasColor: AppColors.slate950,
    dividerColor: AppColors.inactiveDark,
    iconTheme: const IconThemeData(color: AppColors.textLight),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.textLight),
      titleTextStyle: TextStyle(
        color: AppColors.textLight,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textLight),
      bodyMedium: TextStyle(color: AppColors.textLight),
      bodySmall: TextStyle(color: AppColors.textLight),
      titleLarge: TextStyle(color: AppColors.textLight),
      titleMedium: TextStyle(color: AppColors.textLight),
      headlineMedium: TextStyle(color: AppColors.textLight),
      headlineSmall: TextStyle(color: AppColors.textLight),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.blue500,
      secondary: AppColors.cyan400,
      surface: AppColors.slate950,
      onSurface: AppColors.textLight,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
    ),
  );
}