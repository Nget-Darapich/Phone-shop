import 'package:flutter/material.dart';

import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../data/models/phone_model.dart';
import '../widgets/hero_banner.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: CustomAppBar(),

      bottomNavigationBar: CustomBottomNav(selectedIndex: 0),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              HeroBanner(
                imagePath: "assets/images/hero_banner.jpg",
                title: "Discover the Latest Phones",
                subtitle:
                    "Explore our wide range of smartphones and find the perfect one for you.",
              ),

              SizedBox(height: 30),

              Text("Top Brands"),

              SizedBox(height: 20),

              //BrandCircle(),
              SizedBox(height: 30),

              //ProductCard(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
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
                      color: const Color(0xFF38BDF8),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
 
              const SizedBox(height: 16),
 
              // Horizontal scroll of ProductCards
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
