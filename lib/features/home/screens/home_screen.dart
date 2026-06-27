import 'package:flutter/material.dart';

import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../data/models/phone_model.dart';
import '../widgets/brand_card.dart';
import '../widgets/category_card.dart';
import '../widgets/hero_banner.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              /// HERO BANNER
              HeroBanner(
                imagePath: "assets/images/hero_banner.png",
                title: "Latest Phones",
                subtitle: "Titanium. So strong. So light.",
              ),

              const SizedBox(height: 30),

              /// TOP BRANDS
              const Text(
                "Top Brands",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 20),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    BrandCircle(
                      brand: "Apple",
                      onTap: () {
                        print("Apple clicked");
                      },
                    ),

                    const SizedBox(width: 16),

                    BrandCircle(
                      brand: "Samsung",
                      onTap: () {
                        print("Samsung clicked");
                      },
                    ),

                    const SizedBox(width: 16),

                    BrandCircle(
                      brand: "Xiaomi",
                      onTap: () {
                        print("Xiaomi clicked");
                      },
                    ),

                    const SizedBox(width: 16),

                    BrandCircle(
                      brand: "Oppo",
                      onTap: () {
                        print("Oppo clicked");
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              /// CATEGORIES
              const Text(
                "Categories",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 20),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    CategoryCard(icon: Icons.phone_android, title: "Phones"),

                    SizedBox(width: 16),

                    CategoryCard(icon: Icons.tablet_android, title: "Tablets"),

                    SizedBox(width: 16),

                    CategoryCard(icon: Icons.watch, title: "Wearables"),

                    SizedBox(width: 16),

                    CategoryCard(icon: Icons.headphones, title: "Accessories"),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              /// NEW ARRIVALS HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'New Arrivals',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  Text(
                    'See All',
                    style: TextStyle(
                      color: Color(0xFF38BDF8),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// PRODUCT CARDS
              SizedBox(
                height: 290,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: samplePhones.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 14),
                  itemBuilder: (context, i) =>
                      ProductCard(phone: samplePhones[i]),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
