import 'package:flutter/material.dart';

import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../data/models/phone_model.dart';
import '../widgets/hero_banner.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(),
      bottomNavigationBar: const CustomBottomNav(selectedIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeroBanner(
                imagePath: 'assets/images/hero_banner.jpg',
                title: 'Shop the latest smartphone deals',
                subtitle: 'Save on premium phones, trade in your old device, and enjoy fast delivery.',
              ),
              const SizedBox(height: 24),
              _buildSectionTitle(context, 'Shop by category', 'See all'),
              const SizedBox(height: 14),
              SizedBox(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
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
                              color: category.color.withOpacity(0.18),
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
                                samplePhones.first.image,
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
                                  samplePhones.first.name,
                                  style: textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '\$${samplePhones.first.price.toStringAsFixed(0)}',
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
                  itemCount: samplePhones.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 14),
                  itemBuilder: (context, i) => ProductCard(phone: samplePhones[i]),
                ),
              ),
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

class _CategoryData {
  final String label;
  final IconData icon;
  final Color color;

  const _CategoryData({required this.label, required this.icon, required this.color});
}
