import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:phone_shop/data/models/product_model.dart';
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

            icon: SvgPicture.asset(
              "assets/icons/home_icon.svg",
              width: 30,
              height: 30,
              colorFilter: ColorFilter.mode(
                selectedIndex == 0 ? Colors.cyan : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
          ),

          // Compare
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.compare);
            },

            icon: SvgPicture.asset(
              "assets/icons/compare_icon.svg",
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                selectedIndex == 1 ? Colors.cyan : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
          ),

          // Favorite
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.favorite);
            },

            icon: SvgPicture.asset(
              "assets/icons/favorite_icon.svg",
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                selectedIndex == 2 ? Colors.cyan : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
          ),

          // Cart (with badge)
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRouter.cart),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                SvgPicture.asset(
                  "assets/icons/cart_icon.svg",
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    selectedIndex == 3 ? Colors.cyan : Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                Positioned(
                  right: -8,
                  top: -8,
                  child: ValueListenableBuilder<List<String>>(
                    valueListenable: cartIdsNotifier,
                    builder: (context, cartIds, _) {
                      final count = cartIds.length;
                      if (count == 0) return const SizedBox.shrink();
                      final display = count > 99 ? '99+' : count.toString();
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          display,
                          style: const TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Profile/More
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.more);
            },

            icon: SvgPicture.asset(
              "assets/icons/more_icon.svg",
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                selectedIndex == 4 ? Colors.cyan : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
