import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../data/models/product_model.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

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
        title: const Text('Compare'),
      ),
      bottomNavigationBar: const CustomBottomNav(selectedIndex: 1),
      body: ValueListenableBuilder<Set<String>>(
        valueListenable: compareIdsNotifier,
        builder: (context, compareIds, _) {
          final items = compareProducts();
          if (items.isEmpty) {
            return _buildEmpty(context);
          }
          if (items.length == 1) {
            return _buildSingle(context, items.first);
          }
          return _buildComparison(context, items);
        },
      ),
    );
  }

  Widget _buildEmpty(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.compare_rounded,
                  size: 72, color: onSurface.withValues(alpha: 0.25)),
              const SizedBox(height: 16),
              Text(
                'No items to compare yet',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: onSurface.withValues(alpha: 0.6),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tap "Add to Compare" on any product to start.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: onSurface.withValues(alpha: 0.45),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSingle(BuildContext context, ProductModel product) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _ProductCard(product: product, onRemove: () => toggleCompare(product)),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: theme.dividerColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: theme.colorScheme.primary, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Add at least 2 products to see a side-by-side comparison.',
                      style: TextStyle(
                        color: onSurface.withValues(alpha: 0.6),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparison(BuildContext context, List<ProductModel> items) {
    return SafeArea(
      child: Column(
        children: [
          // Product header cards
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                final product = items[i];
                return _ProductCard(
                  product: product,
                  onRemove: () => toggleCompare(product),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          // Spec comparison table
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              children: [
                _SpecRow(
                  label: 'Price',
                  values: items.map((p) => '\$${p.price.toStringAsFixed(0)}').toList(),
                  highlight: true,
                ),
                _SpecRow(
                  label: 'Display',
                  values: items.map((p) => p.displaySpec).toList(),
                ),
                _SpecRow(
                  label: 'Camera',
                  values: items.map((p) => p.cameraSpec).toList(),
                ),
                _SpecRow(
                  label: 'Processor',
                  values: items.map((p) => p.processorSpec).toList(),
                ),
                _SpecRow(
                  label: 'Battery',
                  values: items.map((p) => p.batterySpec).toList(),
                ),
                _SpecRow(
                  label: 'Connectivity',
                  values: items.map((p) => p.connectivitySpec).toList(),
                ),
                _SpecRow(
                  label: 'Storage',
                  values: items.map((p) => p.storage.join(', ')).toList(),
                ),
                _SpecRow(
                  label: 'Colors',
                  values: items.map((p) => p.colors.join(', ')).toList(),
                ),
                _SpecRow(
                  label: 'Rating',
                  values: items.map((p) => '${p.rating} (${p.reviewCount} reviews)').toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Product mini card ──────────────────────────────────────────────────────────
class _ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onRemove;

  const _ProductCard({required this.product, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    final primary = theme.colorScheme.primary;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/product/${product.id}'),
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: Image.asset(product.image, fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => Icon(Icons.phone_android, color: primary.withValues(alpha: 0.4), size: 48),
                  ),
                ),
                Positioned(
                  right: -4,
                  top: -4,
                  child: GestureDetector(
                    onTap: onRemove,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 14, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: onSurface,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '\$${product.price.toStringAsFixed(0)}',
              style: TextStyle(
                color: primary,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Spec comparison row ────────────────────────────────────────────────────────
class _SpecRow extends StatelessWidget {
  final String label;
  final List<String> values;
  final bool highlight;

  const _SpecRow({
    required this.label,
    required this.values,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: highlight ? theme.colorScheme.primary.withValues(alpha: 0.06) : null,
        border: Border(
          bottom: BorderSide(color: theme.dividerColor, width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(
                color: onSurface.withValues(alpha: 0.6),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < values.length; i++)
                  Padding(
                    padding: EdgeInsets.only(bottom: i < values.length - 1 ? 8 : 0),
                    child: Text(
                      values[i],
                      style: TextStyle(
                        color: onSurface,
                        fontSize: highlight ? 15 : 13,
                        fontWeight: highlight ? FontWeight.w700 : FontWeight.w400,
                        height: 1.4,
                      ),
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
