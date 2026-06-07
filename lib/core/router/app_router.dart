import 'package:flutter/material.dart';
import 'package:phone_shop/features/home/screens/home_screen.dart';
import 'package:phone_shop/features/favorites/screens/favorite_screen.dart';
import '../../features/more/screens/more_screen.dart';
import '../../features/more/screens/nearby_stock_screen.dart';
import 'package:phone_shop/features/more/screens/promotions_screen.dart' as promos;
import 'package:phone_shop/features/more/screens/repair_tracker_screen.dart';
import 'package:phone_shop/features/more/screens/reviews_screen.dart';
import 'package:phone_shop/features/cart/screens/cart_screen.dart';
import 'package:phone_shop/features/product/screens/product_detail_screen.dart';

class AppRouter {
  static const String home = '/';
  static const String product = '/product';
  static const String cart = '/cart';
  static const String profile = '/profile';
  static const String favorite = '/favorite';
  static const String compare = '/compare';
  static const String more = '/more';
  static const String nearbyStock = '/nearby_stock';
  static const String promotions = '/promotions';
  static const String repairTracker = '/repair_tracker';
  static const String reviews = '/reviews';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case product:
        return MaterialPageRoute(
          builder: (_) => const ProductDetailScreen(),
          settings: settings, 
        );
        
      case favorite:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());

      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());

      case more:
        return MaterialPageRoute(builder: (_) => const MoreScreen());

      case nearbyStock:
        return MaterialPageRoute(builder: (_) => const NearbyStockScreen());

      case promotions:
        return MaterialPageRoute(builder: (_) => promos.PromotionsScreen());

      case repairTracker:
        return MaterialPageRoute(builder: (_) => const RepairTrackerScreen());

      case reviews:
        return MaterialPageRoute(builder: (_) => const ReviewsScreen());

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
