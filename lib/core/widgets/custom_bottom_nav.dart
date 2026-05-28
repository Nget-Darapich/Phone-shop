import 'package:flutter/material.dart';
import '../router/app_router.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNav({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,

      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        // children: [

        //   Icon(Icons.home),
        //   Icon(Icons.compare),
        //   Icon(Icons.favorite),
        //   Icon(Icons.shopping_cart),
        //   Icon(Icons.menu)

        // ],
        children: [
          // Home
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.home);
            },

            icon: Icon(
              Icons.home,
              color: selectedIndex == 0 ? Colors.cyan : Colors.grey,
            ),
          ),

          // Compare
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.compare);
            },

            icon: Icon(
              Icons.compare,
              color: selectedIndex == 1 ? Colors.cyan : Colors.grey,
            ),
          ),

          // Favorite
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.favorite);
            },

            icon: Icon(
              Icons.favorite,
              color: selectedIndex == 2 ? Colors.cyan : Colors.grey,
            ),
          ),

          // Cart
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.cart);
            },

            icon: Icon(
              Icons.shopping_cart,
              color: selectedIndex == 3 ? Colors.cyan : Colors.grey,
            ),
          ),

          // Profile/More
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.more);
            },

            icon: Icon(
              Icons.menu,
              color: selectedIndex == 4 ? Colors.cyan : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
