import 'package:flutter/material.dart';
import 'package:phone_shop/data/models/product_model.dart';
import 'package:phone_shop/features/auth/screens/auth_screen.dart';
import 'package:phone_shop/features/home/screens/home_screen.dart';
import 'package:phone_shop/features/favorites/screens/favorite_screen.dart';
import '../../features/more/screens/more_screen.dart';
import '../../features/more/screens/nearby_stock_screen.dart';
import 'package:phone_shop/features/more/screens/promotions_screen.dart' as promos;
import 'package:phone_shop/features/more/screens/repair_tracker_screen.dart';
import 'package:phone_shop/features/more/screens/reviews_screen.dart';
import 'package:phone_shop/features/more/screens/book_appointment_screen.dart';
import 'package:phone_shop/features/more/screens/support_chat_screen.dart';
import 'package:phone_shop/features/more/screens/store_locator_screen.dart';
import 'package:phone_shop/features/more/screens/media_review_screen.dart';
import 'package:phone_shop/features/cart/screens/cart_screen.dart';
import 'package:phone_shop/features/product_list/screens/product_list_screen.dart';
import 'package:phone_shop/features/compare/screens/compare_screen.dart';
import 'package:phone_shop/features/product/screens/product_detail_screen.dart';
import 'package:phone_shop/features/checkout/screens/checkout_screen.dart';
import 'package:phone_shop/features/orders/screens/orders_history_screen.dart';
class AppRouter {
  static const String home = '/';
  static String product(String id) => '/product/$id';
  static const String checkout = '/checkout';
  static const String cart = '/cart';
  static const String profile = '/profile';
  static const String favorite = '/favorite';
  static const String compare = '/compare';
  static const String auth = '/auth';
  static const String login = '/login';
  static const String register = '/register';
  static const String more = '/more';
  static const String nearbyStock = '/nearby_stock';
  static const String promotions = '/promotions';
  static const String repairTracker = '/repair_tracker';
  static const String reviews = '/reviews';
  static const String storeLocator = '/store_locator';
  static const String mediaReview = '/media_review';
  static const String bookAppointment = '/book_appointment';
  static const String supportChat = '/support_chat';
  static const String productList = '/product_list';
  static const String ordersHistory = '/orders_history';

  /// All available route names in the app.
  static final Set<String> availableRoutes = {
    home,
    productList,
    cart,
    profile,
    favorite,
    compare,
    auth,
    login,
    register,
    more,
    nearbyStock,
    promotions,
    repairTracker,
    reviews,
    storeLocator,
    mediaReview,
    bookAppointment,
    supportChat,
    ordersHistory,
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (settings.name != null && settings.name!.startsWith('/product/')) {
      final id = settings.name!.substring('/product/'.length);
      try {
        final product = sampleProducts.firstWhere((p) => p.id == id);
        return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: product),
          settings: settings,
        );
      } catch (_) {
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Product not found.')),
          ),
        );
      }
    }

    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen(), settings: settings);

      case checkout:
        return MaterialPageRoute(
          builder: (_) => const CheckoutScreen(),
          settings: settings, 
        );

      case favorite:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen(), settings: settings);

      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen(), settings: settings);

      case more:
        return MaterialPageRoute(builder: (_) => const MoreScreen(), settings: settings);

      case compare:
        return MaterialPageRoute(builder: (_) => const CompareScreen(), settings: settings);

      case auth:
        final page = settings.arguments is int ? settings.arguments as int : 0;
        return MaterialPageRoute(builder: (_) => AuthScreen(initialPage: page), settings: settings);

      case login:
        return MaterialPageRoute(builder: (_) => const AuthScreen(initialPage: 0), settings: settings);

      case register:
        return MaterialPageRoute(builder: (_) => const AuthScreen(initialPage: 1), settings: settings);

      case nearbyStock:
        return MaterialPageRoute(builder: (_) => const NearbyStockScreen(), settings: settings);

      case promotions:
        return MaterialPageRoute(builder: (_) => promos.PromotionsScreen(), settings: settings);

      case repairTracker:
        return MaterialPageRoute(builder: (_) => const RepairTrackerScreen(), settings: settings);

      case reviews:
        return MaterialPageRoute(builder: (_) => const ReviewsScreen(), settings: settings);

      case storeLocator:
        return MaterialPageRoute(builder: (_) => const StoreLocatorScreen(), settings: settings);

      case mediaReview:
        return MaterialPageRoute(builder: (_) => const MediaReviewScreen(), settings: settings);

      case bookAppointment:
        return MaterialPageRoute(builder: (_) => const BookAppointmentScreen(), settings: settings);

      case supportChat:
        return MaterialPageRoute(builder: (_) => const SupportChatScreen(), settings: settings);

      case ordersHistory:
        return MaterialPageRoute(
          builder: (_) => const OrdersHistoryScreen(),
          settings: settings,
        );

      case productList:
        final filter = settings.arguments as ProductListFilter;
        return MaterialPageRoute(
          builder: (_) => ProductListScreen(filter: filter),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
