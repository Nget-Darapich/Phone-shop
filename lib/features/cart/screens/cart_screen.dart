import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const _bg = Color(0xFF020617);
  static const _surface = Color(0xFF0F172A);
  static const _accent = Color(0xFF38BDF8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
            child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.35),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white, size: 18),
          ),
        ),
        title: const Text(
          'Shopping Cart',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        actions: [
          _AppBarIcon(Icons.delete_outline_rounded, onTap: () {}),
          _AppBarIcon(Icons.search_rounded, onTap: () {}),
          _AppBarIcon(Icons.notifications_none_rounded, onTap: () {}),
          _AppBarIcon(Icons.wb_sunny_outlined, onTap: () {}),
          const SizedBox(width: 8),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(selectedIndex: 3),
      body: Column(
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
                        // Cart Items
                        _buildCartItem(
                          productName: 'iPhone 15 Pro Max',
                          brand: 'Apple',
                          price: '\$1,199',
                          quantity: 1,
                          imageUrl: 'assets/icons/iphone.png',
                        ),
                        const SizedBox(height: 16),
                        _buildCartItem(
                          productName: 'Samsung Galaxy S24',
                          brand: 'Samsung',
                          price: '\$899',
                          quantity: 2,
                          imageUrl: 'assets/icons/samsung.png',
                        ),
                        const SizedBox(height: 16),
                        _buildCartItem(
                          productName: 'Google Pixel 8',
                          brand: 'Google',
                          price: '\$699',
                          quantity: 1,
                          imageUrl: 'assets/icons/pixel.png',
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Fixed bottom CTA bar
          Container(
            padding: EdgeInsets.fromLTRB(
                20, 14, 20, MediaQuery.of(context).padding.bottom + 14),
            decoration: BoxDecoration(
              color: _surface,
              border: Border(top: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.07))),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Subtotal',
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.5),
                          fontSize: 14),
                    ),
                    Text(
                      '\$2,797',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Shipping',
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.5),
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
                const Divider(color: Colors.white12),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      '\$2,797',
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
                    onPressed: () {},
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
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem({
    required String productName,
    required String brand,
    required String price,
    required int quantity,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.07)),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              imageUrl,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.phone_android,
                    size: 40, color: Color(0xFF334155));
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brand,
                  style: const TextStyle(
                      color: _accent,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3),
                ),
                const SizedBox(height: 4),
                Text(
                  productName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(
                    color: _accent,
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
                  color: _bg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.1)),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_rounded,
                          color: Colors.white, size: 18),
                      onPressed: () {},
                      padding: const EdgeInsets.all(4),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        quantity.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_rounded,
                          color: Colors.white, size: 18),
                      onPressed: () {},
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
}

class _AppBarIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _AppBarIcon(this.icon, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.08),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
