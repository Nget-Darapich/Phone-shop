import 'package:flutter/material.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../data/models/phone_model.dart';
import '../widgets/color_selector.dart';
import '../widgets/storage_selector.dart';
import '../widgets/specification_tile.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedColor = 0;
  int _selectedStorage = 0;
  bool _isFavorite = false;

  static const _bg = Color(0xFF020617);
  static const _surface = Color(0xFF0F172A);
  static const _accent = Color(0xFF38BDF8);

  @override
  Widget build(BuildContext context) {
    // Receive PhoneModel passed via Navigator arguments
    final phone =
        ModalRoute.of(context)!.settings.arguments as PhoneModel;

    return Scaffold(
      backgroundColor: _bg,
      bottomNavigationBar: CustomBottomNav(selectedIndex: 0),
      body: Column(
        children: [
          // ── Scrollable body ───────────────────────────────────
          Expanded(
            child: CustomScrollView(
              slivers: [
                // ── SliverAppBar with hero image ──────────────
                SliverAppBar(
                  expandedHeight: 300,
                  backgroundColor: _surface,
                  pinned: true,
                  leading: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.35),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white, size: 18),
                    ),
                  ),
                  title: const Text(
                    'Product Details',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  actions: [
                    _AppBarIcon(Icons.search_rounded, onTap: () {}),
                    _AppBarIcon(Icons.notifications_none_rounded,
                        onTap: () {}),
                    _AppBarIcon(Icons.wb_sunny_outlined, onTap: () {}),
                    const SizedBox(width: 8),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          phone.image,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(
                            color: _surface,
                            child: const Icon(Icons.phone_android,
                                size: 120, color: Color(0xFF334155)),
                          ),
                        ),
                        // Gradient overlay so appbar blends
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0.4),
                                Colors.transparent,
                                Colors.transparent,
                                _bg.withValues(alpha: 0.9),
                              ],
                              stops: const [0.0, 0.3, 0.6, 1.0],
                            ),
                          ),
                        ),
                        // Favourite + Share overlaid on image
                        Positioned(
                          top: 0,
                          right: 0,
                          child: SafeArea(
                            child: Column(
                              children: [
                                _RoundedActionButton(
                                  icon: _isFavorite
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  iconColor: _isFavorite
                                      ? Colors.red
                                      : Colors.white,
                                  onTap: () =>
                                      setState(() => _isFavorite = !_isFavorite),
                                ),
                                const SizedBox(height: 8),
                                _RoundedActionButton(
                                  icon: Icons.share_rounded,
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Product info body ──────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Brand name (accent colour)
                        Text(
                          phone.brand,
                          style: const TextStyle(
                              color: _accent,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3),
                        ),
                        const SizedBox(height: 4),

                        // Product name
                        Text(
                          phone.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Rating row
                        Row(
                          children: [
                            const Icon(Icons.star_rounded,
                                color: Color(0xFFFBBF24), size: 18),
                            const SizedBox(width: 4),
                            Text(
                              phone.rating.toString(),
                              style: const TextStyle(
                                  color: Color(0xFFFBBF24),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${phone.reviewCount} reviews',
                              style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.45),
                                  fontSize: 13),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // ── Price block ────────────────────────
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _surface,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: Colors.white.withValues(alpha: 0.07)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Progress bar (decorative)
                              Container(
                                height: 6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF38BDF8),
                                      Color(0xFF0EA5E9)
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '\$${phone.price.toStringAsFixed(0)}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    'or \$${phone.monthlyPrice.toStringAsFixed(2)}/mo for ${phone.monthlyDuration} mos.',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.5),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ── Color selector ─────────────────────
                        Text(
                          'Color - ${phone.colors[_selectedColor]}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        ColorSelector(
                          colors: phone.colors,
                          selectedIndex: _selectedColor,
                          onSelected: (i) =>
                              setState(() => _selectedColor = i),
                        ),

                        const SizedBox(height: 24),

                        // ── Storage selector ───────────────────
                        const Text(
                          'Storage',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        StorageSelector(
                          options: phone.storage,
                          selectedIndex: _selectedStorage,
                          onSelected: (i) =>
                              setState(() => _selectedStorage = i),
                        ),

                        const SizedBox(height: 24),

                        // ── Feature cards (warranty / delivery / return) ──
                        Row(
                          children: [
                            _FeatureCard(
                              icon: Icons.verified_outlined,
                              label: '1 Year\nWarranty',
                            ),
                            const SizedBox(width: 10),
                            _FeatureCard(
                              icon: Icons.local_shipping_outlined,
                              label: 'Free\nDelivery',
                            ),
                            const SizedBox(width: 10),
                            _FeatureCard(
                              icon: Icons.replay_rounded,
                              label: '14 Days\nReturn',
                            ),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // ── Specification tiles ─────────────────
                        SpecificationTile(
                          title: 'Display',
                          content: phone.displaySpec,
                          initiallyExpanded: true,
                        ),
                        SpecificationTile(
                          title: 'Camera',
                          content: phone.cameraSpec,
                        ),
                        SpecificationTile(
                          title: 'Processor & Battery',
                          content:
                              '${phone.processorSpec}\n${phone.batterySpec}',
                        ),
                        SpecificationTile(
                          title: 'Connectivity',
                          content: phone.connectivitySpec,
                        ),

                        const SizedBox(height: 100), // space above CTA bar
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Fixed bottom CTA bar ──────────────────────────────
          Container(
            padding: EdgeInsets.fromLTRB(
                20, 14, 20, MediaQuery.of(context).padding.bottom + 14),
            decoration: BoxDecoration(
              color: _surface,
              border:
                  Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.07))),
            ),
            child: Row(
              children: [
                // Reserve in Store
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text('Reserve in Store',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14)),
                  ),
                ),
                const SizedBox(width: 12),
                // Buy Now
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      AppRouter.checkout,
                      arguments: phone.price,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accent,
                      foregroundColor: const Color(0xFF020617),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      elevation: 0,
                    ),
                    child: const Text('Buy Now',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Private helpers ─────────────────────────────────────────────────────────

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
          color: Colors.white.withValues(alpha: 0.08),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}

class _RoundedActionButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _RoundedActionButton({
    required this.icon,
    required this.onTap,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 12, right: 14),
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.35),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FeatureCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF38BDF8), size: 22),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.65),
                  fontSize: 11,
                  height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}