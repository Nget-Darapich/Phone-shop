import 'package:flutter/material.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../data/models/product_model.dart';
import '../widgets/color_selector.dart';
import '../widgets/storage_selector.dart';
import '../widgets/specification_tile.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedColor = 0;
  int _selectedStorage = 0;

  static const _accent = Color(0xFF38BDF8);

  void _showSnack(BuildContext context, String message, {Duration? duration, SnackBarAction? action}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? const Duration(milliseconds: 900),
        content: GestureDetector(
          onTap: () => ScaffoldMessenger.of(context).clearSnackBars(),
          child: Text(message),
        ),
        action: action,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    final textTheme = theme.textTheme;
    final divider = theme.dividerColor;
    final card = theme.cardColor;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
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
                  backgroundColor: card,
                  pinned: true,
                  leading: GestureDetector(
                    onTap: () => Navigator.pushNamedAndRemoveUntil(context, AppRouter.home, (route) => false),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: onSurface.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_back_ios_new_rounded,
                          color: onSurface, size: 18),
                    ),
                  ),
                  title: Text(
                    'Product Details',
                    style: textTheme.titleMedium?.copyWith(color: onSurface),
                  ),
                  actions: const [SizedBox(width: 8)],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          product.image,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Container(
                            color: card,
                            child: Icon(Icons.phone_android,
                                size: 120, color: onSurface.withValues(alpha: 0.3)),
                          ),
                        ),
                        // Gradient overlay so appbar blends
                        Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromRGBO(0, 0, 0, 0.4),
                                    Colors.transparent,
                                    Colors.transparent,
                                    Color.fromRGBO(2, 6, 23, 0.9),
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
                                ValueListenableBuilder<Set<String>>(
                                  valueListenable: favoriteIdsNotifier,
                                  builder: (context, favorites, _) {
                                    final isFavorite = favorites.contains(product.id);
                                    return _RoundedActionButton(
                                      icon: isFavorite
                                          ? Icons.favorite_rounded
                                          : Icons.favorite_border_rounded,
                                      iconColor:
                                          isFavorite ? Colors.red : Colors.white,
                                      onTap: () => toggleFavorite(product),
                                    );
                                  },
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
                          product.brand.name[0].toUpperCase() + product.brand.name.substring(1),
                          style: const TextStyle(
                              color: _accent,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3),
                        ),
                        const SizedBox(height: 4),

                        // Product name
                        Text(
                          product.name,
                          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'ID: ${product.id}',
                          style: TextStyle(
                            color: onSurface.withValues(alpha: 0.45),
                            fontSize: 12,
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
                              product.rating.toString(),
                              style: const TextStyle(
                                  color: Color(0xFFFBBF24),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${product.reviewCount} reviews',
                              style: TextStyle(
                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.55),
                                  fontSize: 13),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),
                        Text(
                          product.description,
                          style: TextStyle(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _InfoChip(
                              icon: Icons.palette_outlined,
                              label: '${product.colors.length} colors',
                            ),
                            _InfoChip(
                              icon: Icons.sd_storage,
                              label: product.storage.first,
                            ),
                            _InfoChip(
                              icon: Icons.bolt_outlined,
                              label: 'Fast charge',
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // ── Price block ────────────────────────
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: card,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: divider),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '\$${product.price.toStringAsFixed(0)}',
                                      style: textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'or \$${product.monthlyPrice.toStringAsFixed(2)}/mo for ${product.monthlyDuration} mos.',
                                      style: TextStyle(
                                        color: onSurface.withValues(alpha: 0.65),
                                        fontSize: 12,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
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
                          'Color - ${product.colors[_selectedColor]}',
                          style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        ColorSelector(
                          colors: product.colors,
                          selectedIndex: _selectedColor,
                          onSelected: (i) =>
                              setState(() => _selectedColor = i),
                        ),

                        const SizedBox(height: 24),

                        // ── Storage selector ───────────────────
                        Text(
                          'Storage',
                          style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        StorageSelector(
                          options: product.storage,
                          selectedIndex: _selectedStorage,
                          onSelected: (i) =>
                              setState(() => _selectedStorage = i),
                        ),

                        const SizedBox(height: 24),

                        // ── Feature cards (warranty / delivery / return) ──
                        Row(
                          children: const [
                            Expanded(child: _FeatureCard(
                              icon: Icons.verified_outlined,
                              label: '1 Year\nWarranty',
                            )),
                            SizedBox(width: 10),
                            Expanded(child: _FeatureCard(
                              icon: Icons.local_shipping_outlined,
                              label: 'Free\nDelivery',
                            )),
                            SizedBox(width: 10),
                            Expanded(child: _FeatureCard(
                              icon: Icons.replay_rounded,
                              label: '14 Days\nReturn',
                            )),
                          ],
                        ),

                        const SizedBox(height: 28),

                        // ── Specification tiles ─────────────────
                        SpecificationTile(
                          title: 'Display',
                          content: product.displaySpec,
                          initiallyExpanded: true,
                        ),
                        SpecificationTile(
                          title: 'Camera',
                          content: product.cameraSpec,
                        ),
                        SpecificationTile(
                          title: 'Processor & Battery',
                          content:
                              '${product.processorSpec}\n${product.batterySpec}',
                        ),
                        SpecificationTile(
                          title: 'Connectivity',
                          content: product.connectivitySpec,
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
          ValueListenableBuilder<Set<String>>(
            valueListenable: compareIdsNotifier,
            builder: (context, compareIds, _) {
              final isCompared = compareIds.contains(product.id);
              return ValueListenableBuilder<List<String>>(
                valueListenable: cartIdsNotifier,
                builder: (context, cartIds, _) {
                  final inCart = cartIds.contains(product.id);
                  return Container(
                    padding: EdgeInsets.fromLTRB(
                        20, 14, 20, MediaQuery.of(context).padding.bottom + 14),
                    decoration: BoxDecoration(
                      color: card,
                      border: Border(top: BorderSide(color: divider)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              if (!isCompared && compareIds.length >= maxCompare) {
                                _showSnack(context, 'Compare list is full (max 4)',
                                    duration: const Duration(milliseconds: 1200));
                                return;
                              }
                              final added = toggleCompare(product);
                              if (added) {
                                _showSnack(context, 'Added to compare list',
                                  action: SnackBarAction(
                                    label: 'View',
                                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                        context, AppRouter.compare, (route) => false),
                                  ),
                                );
                              } else if (!isCompared) {
                                _showSnack(context, 'Removed from compare list');
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: onSurface,
                              side: BorderSide(color: divider),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                            ),
                            child: Text(
                              isCompared ? 'Compared' : 'Add to Compare',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              addToCart(product);
                              _showSnack(context, inCart
                                  ? 'Added another item to cart'
                                  : 'Added to cart',
                                action: SnackBarAction(
                                  label: 'View cart',
                                  onPressed: () => Navigator.pushNamed(context, AppRouter.cart),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _accent,
                              foregroundColor: const Color(0xFF020617),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              elevation: 0,
                            ),
                            child: Text(
                              inCart ? 'Add Again' : 'Add to Cart',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// ── Private helpers ─────────────────────────────────────────────────────────

class _RoundedActionButton extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onTap;

  const _RoundedActionButton({
    required this.icon,
    required this.onTap,
    this.iconColor,
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
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor ?? Theme.of(context).colorScheme.onSurface, size: 20),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: onSurface.withValues(alpha: 0.7),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
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
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 22),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: onSurface.withValues(alpha: 0.65),
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}