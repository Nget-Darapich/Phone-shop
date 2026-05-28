import 'package:flutter/material.dart';
import 'package:phone_shop/core/widgets/custom_bottom_nav.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Favorites"),
      ),

      body: const Center(
        child: Text(
          "Favorite Screen",
        ),
      ),
      bottomNavigationBar:
        CustomBottomNav(
          selectedIndex:2,
        ),
    );
  }
}