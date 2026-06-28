import 'package:flutter/material.dart';

/// Simple app-wide ThemeMode notifier.
class ThemeNotifier extends ValueNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light);

  void toggle() {
    value = value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  void setMode(ThemeMode mode) => value = mode;
}

final themeNotifier = ThemeNotifier();
