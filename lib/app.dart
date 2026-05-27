import 'package:flutter/material.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Phone Shop',

      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,

      darkTheme: AppTheme.darkTheme,

      // For now while implementing Figma
      themeMode: ThemeMode.dark,

      initialRoute: AppRouter.home,

      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}