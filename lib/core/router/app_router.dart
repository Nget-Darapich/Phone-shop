import 'package:flutter/material.dart';
import 'package:phone_shop/features/home/screens/home_screen.dart';
import 'package:phone_shop/features/favorites/screens/favorite_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String product = '/product';
  static const String cart = '/cart';
  static const String profile = '/profile';
  static const String favorite = '/favorite';
  static const String compare = '/compare';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case favorite:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());

      // case compare:
      //   return MaterialPageRoute(builder: (_) => const CompareScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
