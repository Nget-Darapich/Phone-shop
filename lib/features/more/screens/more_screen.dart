import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/theme_notifier.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Account',
          style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
            onPressed: () {},
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_outlined, color: Theme.of(context).iconTheme.color),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ), 
              ),
            ],
          ),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (context, mode, _) {
              final isDark = mode == ThemeMode.dark;
              return IconButton(
                icon: Icon(isDark ? Icons.dark_mode : Icons.wb_sunny_outlined, color: Theme.of(context).iconTheme.color),
                onPressed: () => themeNotifier.toggle(),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(selectedIndex: 4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // User Profile Section
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Colors.cyan, Colors.blue],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'KD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'KAKDA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'kakda@example.com',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Removed inline login/register buttons to use the profile icon entrypoint instead.

              ValueListenableBuilder(
                valueListenable: themeNotifier,
                builder: (context, ThemeMode mode, _) {
                  return SwitchListTile.adaptive(
                    title: const Text('Dark Mode'),
                    value: mode == ThemeMode.dark,
                    onChanged: (_) => themeNotifier.toggle(),
                  );
                },
              ),

              // Menu Items
              _buildMenuItem(
                context,
                iconPath: 'assets/icons/map_icon.png',
                title: 'Store Locator',
                routeName: AppRouter.storeLocator,
              ),
              _buildMenuItem(
                context,
                iconPath: 'assets/icons/Promotions_icon.png',
                title: 'Media Review',
                routeName: AppRouter.mediaReview,
              ),
              _buildMenuItem(
                context,
                iconPath: 'assets/icons/Nearby_Stock_icon.png',
                title: 'Nearby Stock',
                routeName: AppRouter.nearbyStock,
              ),
              _buildMenuItem(
                context,
                iconPath: 'assets/icons/map_icon.png',
                title: 'Repair Tracker',
                routeName: AppRouter.repairTracker,
              ),
              _buildMenuItem(
                context,
                iconPath: 'assets/icons/Promotions_icon.png',
                title: 'Promotions',
                routeName: AppRouter.promotions,
              ),
              _buildMenuItem(
                context,
                iconPath: 'assets/icons/Book_icon.png',
                title: 'Book Appointment',
                routeName: AppRouter.bookAppointment,
              ),
              _buildMenuItem(
                context,
                iconPath: 'assets/icons/Support_Chat_icon.png',
                title: 'Support Chat',
                routeName: AppRouter.supportChat,
              ),
              _buildMenuItem(
                context,
                icon: Icons.receipt_long_rounded,
                title: 'My Orders',
                routeName: AppRouter.ordersHistory,
              ),
              _buildMenuItem(
                context,
                iconPath: 'assets/icons/Reviews_icon.png',
                title: 'Reviews',
                routeName: AppRouter.reviews,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {
    String? iconPath,
    required String title,
    String? routeName,
    IconData? icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          leading: icon != null
              ? Icon(icon, size: 24, color: Theme.of(context).iconTheme.color)
              : Image.asset(
                  iconPath!,
                  width: 24,
                  height: 24,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error_outline, color: Theme.of(context).iconTheme.color);
                  },
                ),
          title: Text(
            title,
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 16),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).iconTheme.color?.withValues(alpha: 0.6),
            size: 16,
          ),
          onTap: () {
            if (routeName == null) return;
            if (AppRouter.availableRoutes.contains(routeName)) {
              Navigator.of(context).pushNamed(routeName);
            } else {
              showDialog<void>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Page not available'),
                  content: Text('The page for "$title" is not implemented yet.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('OK'))
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
