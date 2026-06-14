import 'package:flutter/material.dart';
import 'package:phone_shop/data/models/product_model.dart';

class ProductListFilter {
  final ProductBrand? brand;
  final ProductCategory? category;
  final bool isNewArrivals; 

  const ProductListFilter.byBrand(ProductBrand b)
      : brand = b,
        category = null,
        isNewArrivals = false;

  const ProductListFilter.byCategory(ProductCategory c)
      : brand = null,
        category = c,
        isNewArrivals = false;

  const ProductListFilter.newArrivals()
      : brand = null,
        category = null,
        isNewArrivals = true;

  String get title {
    if (isNewArrivals) return 'New Arrivals'; 
    if (brand != null) {
      final name = brand!.name;
      return name[0].toUpperCase() + name.substring(1);
    }
    switch (category!) {
      case ProductCategory.phones:
        return 'Phones';
      case ProductCategory.tablets:
        return 'Tablets';
      case ProductCategory.wearables:
        return 'Wearables';
      case ProductCategory.accessories:
        return 'Accessories';
    }
  }

  List<ProductModel> apply(List<ProductModel> all) {
    if (isNewArrivals) {
      return all.where((p) => p.isNew).toList(); 
    }
    if (brand != null) {
      return all.where((p) => p.brand == brand).toList();
    }
    return all.where((p) => p.category == category).toList();
  }
}

// ── Screen ───────────────────────────────────────────────────────────────────

class ProductListScreen extends StatelessWidget {
  final ProductListFilter filter;

  const ProductListScreen({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    final products = filter.apply(sampleProducts);

    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          filter.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: products.isEmpty ? _EmptyState(filter: filter) : _ProductGrid(products: products),
    );
  }
}

// ── Grid ─────────────────────────────────────────────────────────────────────

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

// ── Card ─────────────────────────────────────────────────────────────────────

class _ProductGridCard extends StatelessWidget {
  final ProductModel product;
  const _ProductGridCard({required this.product});

  @override
  Widget build(BuildContext context) {
        // Formatting brand name beautifully (e.g., apple -> Apple)
    final brandName = product.brand.name[0].toUpperCase() + product.brand.name.substring(1);

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/product',
        arguments: product,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF1E293B), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                  width: double.infinity,
                  color: const Color(0xFF1E293B),
                  child: Image.asset(
                    product.image,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => const Center(
                      child: Icon(
                        Icons.phone_android_rounded,
                        color: Color(0xFF38BDF8),
                        size: 52,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand chip
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF38BDF8).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      brandName,
                      style: const TextStyle(
                        color: Color(0xFF38BDF8),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    product.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Color(0xFFFBBF24), size: 13),
                      const SizedBox(width: 3),
                      Text(
                        '${product.rating}  (${product.reviewCount})',
                        style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '\$${product.price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Color(0xFF38BDF8),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
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
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final ProductListFilter filter;
  const _EmptyState({required this.filter});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.inventory_2_outlined, color: Color(0xFF334155), size: 72),
          const SizedBox(height: 16),
          Text(
            'No ${filter.title} found',
            style: const TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Check back later for new arrivals.',
            style: TextStyle(color: Color(0xFF475569), fontSize: 13),
          ),
        ],
      ),
    );
  }
}