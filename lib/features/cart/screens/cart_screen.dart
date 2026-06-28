import 'package:flutter/material.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../data/models/product_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const _accent = Color(0xFF38BDF8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false),
        ),
        title: const Text('Shopping Cart'),
      ),
      bottomNavigationBar: const CustomBottomNav(selectedIndex: 3),
      body: ValueListenableBuilder<List<String>>(
        valueListenable: cartIdsNotifier,
        builder: (context, cartIds, _) {
          final quantityById = <String, int>{};
          for (final id in cartIds) {
            quantityById[id] = (quantityById[id] ?? 0) + 1;
          }

          if (quantityById.isEmpty) {
            return SafeArea(
              child: Center(
                child: Text(
                  'Your cart is empty. Add a product to start shopping.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            );
          }

          final cartItems = quantityById.entries
              .map((entry) {
                final phone = sampleProducts.firstWhere(
                  (phone) => phone.id == entry.key,
                  orElse: () => sampleProducts.first,
                );
                return MapEntry(phone, entry.value);
              })
              .toList();

          final subtotal = cartItems.fold<double>(
            0,
            (sum, entry) => sum + entry.key.price * entry.value,
          );

          return Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (final entry in cartItems) ...[
                              _buildCartItem(context,
                                phone: entry.key,
                                quantity: entry.value,
                              ),
                              const SizedBox(height: 16),
                            ],
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _buildCartFooter(context, subtotal),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, {
    required ProductModel phone,
    required int quantity,
  }) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    final primary = theme.colorScheme.primary;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: onSurface.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              phone.image,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.phone_android,
                    size: 40, color: onSurface.withValues(alpha: 0.3));
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  phone.brand.name[0].toUpperCase() + phone.brand.name.substring(1),
                  style: TextStyle(
                      color: primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3),
                ),
                const SizedBox(height: 4),
                Text(
                  phone.name,
                  style: TextStyle(
                    color: onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${(phone.price * quantity).toStringAsFixed(0)}',
                  style: TextStyle(
                    color: primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: theme.canvasColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_rounded,
                          color: onSurface, size: 18),
                      onPressed: () {
                        removeFromCart(phone);
                      },
                      padding: const EdgeInsets.all(4),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        quantity.toString(),
                        style: TextStyle(
                            color: onSurface,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_rounded,
                          color: onSurface, size: 18),
                      onPressed: () {
                        addToCart(phone);
                      },
                      padding: const EdgeInsets.all(4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCartFooter(BuildContext context, double subtotal) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 14, 20, MediaQuery.of(context).padding.bottom + 14),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(top: BorderSide(color: theme.dividerColor)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: TextStyle(
                    color: onSurface.withValues(alpha: 0.5),
                    fontSize: 14),
              ),
              Text(
                '\$${subtotal.toStringAsFixed(0)}',
                style: TextStyle(
                    color: onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shipping',
                style: TextStyle(
                    color: onSurface.withValues(alpha: 0.5),
                    fontSize: 14),
              ),
              Text(
                'Free',
                style: const TextStyle(
                    color: _accent,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(color: theme.dividerColor),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                    color: onSurface,
                    fontSize: 18,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                '\$${subtotal.toStringAsFixed(0)}',
                style: const TextStyle(
                    color: _accent,
                    fontSize: 24,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context, AppRouter.checkout, arguments: subtotal),
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent,
                foregroundColor: const Color(0xFF020617),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: const Text('Checkout',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}

