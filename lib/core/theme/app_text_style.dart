import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyle {

  static const title = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
  );

  static const subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textLight,
  );

  static const body = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondaryDark,
  );

}