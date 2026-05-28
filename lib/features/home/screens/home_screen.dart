import 'package:flutter/material.dart';

import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../widgets/hero_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF020617),

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

              Text("New Arrivals"),

              SizedBox(height: 20),

              //ProductCard(),
            ],
          ),
        ),
      ),
    );
  }
}
