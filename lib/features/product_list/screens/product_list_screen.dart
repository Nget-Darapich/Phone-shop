import 'package:flutter/material.dart';
import 'package:phone_shop/core/router/app_router.dart';
import 'package:phone_shop/data/models/product_model.dart';

class ProductListScreen extends StatelessWidget {
  final ProductListFilter filter;
  const ProductListScreen({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    final products = filter.apply(sampleProducts);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor ?? theme.canvasColor,
        foregroundColor: theme.appBarTheme.foregroundColor ?? onSurface,
        elevation: 0,
        title: Text(
          filter.title,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: products.isEmpty
          ? _EmptyState(filter: filter)
          : _ProductGrid(products: products),
    );
  }
}

class _ProductGrid extends StatelessWidget {
  final List<ProductModel> products;
  const _ProductGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.62,
        ),
        itemBuilder: (context, i) => _ProductGridCard(product: products[i]),
      ),
    );
  }
}

class _ProductGridCard extends StatelessWidget {
  final ProductModel product;
  const _ProductGridCard({required this.product});

  String get _brandName =>
      product.brand.name[0].toUpperCase() + product.brand.name.substring(1);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;
    final primary = theme.colorScheme.primary;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRouter.product(product.id)),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.dividerColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                  width: double.infinity,
                  color: theme.dividerColor,
                  child: Image.asset(
                    product.image,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => Center(
                      child: Icon(Icons.phone_android_rounded, color: primary, size: 52),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(_brandName,
                        style: TextStyle(color: primary, fontSize: 10, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 6),
                  Text(product.name,
                      style: TextStyle(color: onSurface, fontSize: 13, fontWeight: FontWeight.w600),
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Color(0xFFFBBF24), size: 13),
                      const SizedBox(width: 3),
                      Text('${product.rating}  (${product.reviewCount})',
                          style: TextStyle(color: onSurface.withValues(alpha: 0.6), fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('\$${product.price.toStringAsFixed(0)}',
                      style: TextStyle(color: primary, fontSize: 15, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final ProductListFilter filter;
  const _EmptyState({required this.filter});

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inventory_2_outlined,
              color: onSurface.withValues(alpha: 0.3), size: 72),
          const SizedBox(height: 16),
          Text('No ${filter.title} found',
              style: TextStyle(
                  color: onSurface.withValues(alpha: 0.6),
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text('Check back later for new arrivals.',
              style: TextStyle(
                  color: onSurface.withValues(alpha: 0.5), fontSize: 13)),
        ],
      ),
    );
  }
}
