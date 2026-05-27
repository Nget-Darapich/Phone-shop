import 'package:flutter/material.dart';

class AppColors {

  // BRAND / ACCENT

  static const cyan400 = Color(0xFF22D3EE);

  static const blue500 = Color(0xFF3B82F6);

  static const blue600 = Color(0xFF2563EB);

  static const indigo400 = Color(0xFF818CF8);

  static const gradient = LinearGradient(
    colors: [
      cyan400,
      blue500,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // BACKGROUND

  static const slate50 = Color(0xFFF8FAFC);

  static const slate100 = Color(0xFFF1F5F9);

  static const slate900 = Color(0xFF0F172A);

  static const slate950 = Color(0xFF020617);


  // TEXT

  static const textDark = Color(0xFF0F172A);

  static const textLight = Color(0xFFF8FAFC);

  static const textSecondaryLight =
      Color(0xFF64748B);

  static const textSecondaryDark =
      Color(0xFF94A3B8);

  static const inactiveLight =
      Color(0xFFCBD5E1);

  static const inactiveDark =
      Color(0xFF475569);

  // STATUS

  static const success = Color(0xFF22C55E);

  static const warning = Color(0xFFF59E0B);

  static const error = Color(0xFFEF4444);

  // GLASS EFFECT

  static const glassDark =
      Color.fromRGBO(
        255,
        255,
        255,
        0.10,
      );

  static const glassBorderDark =
      Color.fromRGBO(
        255,
        255,
        255,
        0.15,
      );

  static const glassLight =
      Color.fromRGBO(
        255,
        255,
        255,
        0.60,
      );

  static const glassBorderLight =
      Color.fromRGBO(
        255,
        255,
        255,
        0.40,
      );

  // PRODUCT COLORS
  
  static const iphoneTitanium =
      Color(0xFF8F8E8C);

  static const iphoneBlueTitanium =
      Color(0xFF2F3C4D);

  static const iphoneBlackTitanium =
      Color(0xFF1C1C1E);

  static const galaxyGray =
      Color(0xFF7A7A7A);

  static const xiaomiBlack =
      Color(0xFF111111);

}