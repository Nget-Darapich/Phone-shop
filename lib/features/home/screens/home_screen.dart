import 'package:flutter/material.dart';

import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../data/models/product_model.dart';
import '../widgets/brand_card.dart';
import '../widgets/category_card.dart';
import '../widgets/hero_banner.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final List<BrandItem> brandItems = [
    BrandItem(name: 'Apple', brand: ProductBrand.apple, color: Color(0xFF3B82F6)),
    BrandItem(name: 'Samsung', brand: ProductBrand.samsung, color: Color(0xFF0EA5E9)),
    BrandItem(name: 'Xiaomi', brand: ProductBrand.xiaomi, color: Color(0xFFFB923C)),
    BrandItem(name: 'Oppo', brand: ProductBrand.oppo, color: Color(0xFF22C55E)),
  ];

  static final List<CategoryItem> categoryItems = [
    CategoryItem(icon: Icons.phone_android, title: 'Phones', category: ProductCategory.phones, color: Color(0xFF38BDF8)),
    CategoryItem(icon: Icons.tablet_android, title: 'Tablets', category: ProductCategory.tablets, color: Color(0xFF818CF8)),
    CategoryItem(icon: Icons.watch, title: 'Wearables', category: ProductCategory.wearables, color: Color(0xFFA855F7)),
    CategoryItem(icon: Icons.headphones, title: 'Accessories', category: ProductCategory.accessories, color: Color(0xFF22C55E)),
  ];

  static final List<_CategoryData> _categories = [
    _CategoryData(label: 'Deals', icon: Icons.local_offer_rounded, color: Color(0xFF38BDF8)),
    _CategoryData(label: 'New', icon: Icons.new_releases_rounded, color: Color(0xFF8B5CF6)),
    _CategoryData(label: 'Promotion', icon: Icons.campaign_rounded, color: Color(0xFFFB7185)),
    _CategoryData(label: 'Best Seller', icon: Icons.star_rounded, color: Color(0xFFF97316)),
    _CategoryData(label: 'Accessories', icon: Icons.headphones_rounded, color: Color(0xFF22C55E)),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: const Color(0xFF020617),
      appBar: CustomAppBar(),
      bottomNavigationBar: const CustomBottomNav(selectedIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeroBanner(
                imagePath: 'assets/images/hero_banner.png',
                title: 'Latest Phones',
                subtitle: 'Titanium. So strong. So light.',
              ),
              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0B1423), Color(0xFF111C33)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Top Brands',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white70,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(40, 24),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text('See all'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 150,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: brandItems.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 18),
                        itemBuilder: (context, index) {
                          final item = brandItems[index];
                          return BrandCircle(
                            brand: item.name,
                            backgroundColor: item.color,
                            onTap: () => Navigator.pushNamed(
                              context,
                              '/product_list',
                              arguments: ProductListFilter.byBrand(item.brand),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0C172A), Color(0xFF08101F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Categories',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white70,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(40, 24),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text('Browse all'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 148,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryItems.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final item = categoryItems[index];
                          return CategoryCard(
                            icon: item.icon,
                            title: item.title,
                            accentColor: item.color,
                            onTap: () => Navigator.pushNamed(
                              context,
                              '/product_list',
                              arguments: ProductListFilter.byCategory(item.category),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              _buildSectionTitle(context, 'Shop by category', 'See all'),
              const SizedBox(height: 14),
              SizedBox(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return Container(
                      width: 130,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: Theme.of(context).dividerColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: category.color.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(category.icon, color: category.color, size: 24),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            category.label,
                            style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Shop now',
                            style: textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle(context, 'Flash sale', 'View all'),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Special offer',
                      style: textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Up to 30% off selected flagship phones. Limited time only.',
                      style: textTheme.bodyMedium?.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        _buildPromoBadge('Hot Deal'),
                        const SizedBox(width: 10),
                        _buildPromoBadge('Free Delivery'),
                      ],
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      height: 180,
                      child: Stack(
                        children: [
                          Positioned(
                            right: -10,
                            bottom: -10,
                            child: Opacity(
                              opacity: 0.85,
                              child: Image.asset(
                                sampleProducts.first.image,
                                width: 180,
                                height: 180,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  sampleProducts.first.name,
                                  style: textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '\$${sampleProducts.first.price.toStringAsFixed(0)}',
                                  style: textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle(context, 'New arrivals', 'See all'),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: sampleProducts.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 14),
                  itemBuilder: (context, i) => ProductCard(product: sampleProducts[i]),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, String actionTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        Text(
          actionTitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  Widget _buildPromoBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class BrandItem {
  final String name;
  final ProductBrand brand;
  final Color color;

  const BrandItem({required this.name, required this.brand, required this.color});
}

class CategoryItem {
  final IconData icon;
  final String title;
  final ProductCategory category;
  final Color color;

  const CategoryItem({required this.icon, required this.title, required this.category, required this.color});
}

class _CategoryData {
  final String label;
  final IconData icon;
  final Color color;

  const _CategoryData({required this.label, required this.icon, required this.color});
}
