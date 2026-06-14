// import 'package:flutter/material.dart';
// import '../../../core/widgets/custom_appbar.dart';
// import '../../../core/widgets/custom_bottom_nav.dart';
// import '../../../data/models/phone_model.dart';
// import '../widgets/hero_banner.dart';
// import '../widgets/product_card.dart';
// import '../widgets/brand_card.dart';
// import '../widgets/category_card.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF020617),
//       appBar: CustomAppBar(),
//       bottomNavigationBar: CustomBottomNav(selectedIndex: 0),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               HeroBanner(
//                 imagePath: "assets/images/hero_banner.png",
//                 title: "Latest Phones",
//                 subtitle: "Titanium. So strong. So light.",
//               ),

//               SizedBox(height: 30),

//               const Text(
//                 "Top Brands",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),

//               const SizedBox(height: 20),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   BrandCircle(
//                     brand: "Apple",
//                     onTap: () {
//                       print("Apple clicked");
//                     },
//                   ),

//                   BrandCircle(brand: "Samsung", onTap: () {}),

//                   BrandCircle(brand: "Xiaomi", onTap: () {}),

//                   BrandCircle(brand: "Oppo", onTap: () {}),
//                 ],
//               ),
//               // SizedBox(height: 30),
//               const SizedBox(height: 40),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,

//                 children: const [
//                   CategoryCard(icon: Icons.phone_android, title: "Phones"),

//                   CategoryCard(icon: Icons.tablet_android, title: "Tablets"),

//                   CategoryCard(icon: Icons.watch, title: "Wearables"),

//                   CategoryCard(icon: Icons.headphones, title: "Accessories"),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'New Arrivals',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//               // ── Hero banner ──────────────────────────────────────
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//                 child: HeroBanner(
//                   imagePath: 'assets/images/hero_banner.jpg',
//                   title: 'Discover the Latest Phones',
//                   subtitle:
//                       'Explore our wide range of smartphones and find the perfect one for you.',
//                 ),
//               ),

//               const SizedBox(height: 30),

//               // ── Top Brands ───────────────────────────────────────
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Text(
//                   'Top Brands',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 20),
//               // BrandCircle() goes here
//               const SizedBox(height: 30),

//               // ── New Arrivals header ──────────────────────────────
//               // Padding only left/right — Row now has full screen width
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       'New Arrivals',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     const Text(
//                       'See All',
//                       style: TextStyle(
//                         color: Color(0xFF38BDF8),
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // Horizontal scroll of ProductCards
//               // ── Product card list — no horizontal padding so cards
//               //    bleed to the edge and the ListView gets full width ──
//               SizedBox(
//                 height: 290,
//                 child: ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   itemCount: samplePhones.length,
//                   separatorBuilder: (_, _) => const SizedBox(width: 14),
//                   itemBuilder: (context, i) =>
//                       ProductCard(phone: samplePhones[i]),
//                 ),
//               ),

//               const SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../data/models/product_model.dart';
import '../../product_list/screens/product_list_screen.dart';
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
                        Navigator.pushNamed(
                          context,
                          '/product_list',
                          arguments: const ProductListFilter.byBrand(ProductBrand.apple),
                        );
                      },
                    ),

                    const SizedBox(width: 16),

                    BrandCircle(
                      brand: "Samsung",
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/product_list',
                          arguments: const ProductListFilter.byBrand(ProductBrand.samsung),
                        );
                      },
                    ),

                    const SizedBox(width: 16),

                    BrandCircle(
                      brand: "Xiaomi",
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/product_list',
                          arguments: const ProductListFilter.byBrand(ProductBrand.xiaomi),
                        );
                      },
                    ),

                    const SizedBox(width: 16),

                    BrandCircle(
                      brand: "Oppo",
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/product_list',
                          arguments: const ProductListFilter.byBrand(ProductBrand.oppo),
                        );
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
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/product_list',
                          arguments: const ProductListFilter.byCategory(ProductCategory.phones),
                        );
                      },
                      child: const CategoryCard(icon: Icons.phone_android, title: "Phones"),
                    ),

                    const SizedBox(width: 16),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/product_list',
                          arguments: const ProductListFilter.byCategory(ProductCategory.tablets),
                        );
                      },
                      child: const CategoryCard(icon: Icons.tablet_android, title: "Tablets"),
                    ),

                    const SizedBox(width: 16),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/product_list',
                          arguments: const ProductListFilter.byCategory(ProductCategory.wearables),
                        );
                      },
                      child: const CategoryCard(icon: Icons.watch, title: "Wearables"),
                    ),

                    const SizedBox(width: 16),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/product_list',
                          arguments: const ProductListFilter.byCategory(ProductCategory.accessories),
                        );
                      },
                      child: const CategoryCard(icon: Icons.headphones, title: "Accessories"),
                    ),
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
                  itemCount: sampleProducts.where((p) => p.isNew).length, 
                  separatorBuilder: (_, _) => const SizedBox(width: 14),
                  itemBuilder: (context, i) {
                    final product = sampleProducts.where((p) => p.isNew).elementAt(i);
                    return ProductCard(product: product);
                  },
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
