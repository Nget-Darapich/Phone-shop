import 'package:flutter/material.dart';
import 'package:phone_shop/core/router/app_router.dart';
import 'package:phone_shop/core/widgets/custom_bottom_nav.dart';
import '../../../data/models/phone_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: ValueListenableBuilder<Set<String>>(
        valueListenable: favoriteIdsNotifier,
        builder: (context, favorites, _) {
          final items = samplePhones
              .where((phone) => favorites.contains(phone.id))
              .toList();

          if (items.isEmpty) {
            return Center(
              child: Text(
                'No favorites yet. Tap the heart icon on a product to save it.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7) ?? Colors.black54,
                  fontSize: 16,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final phone = items[index];
              return InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRouter.product,
                  arguments: phone,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.08)),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          phone.image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 80,
                            height: 80,
                            color: const Color(0xFF1E293B),
                            child: const Icon(Icons.phone_android,
                                color: Color(0xFF64748B)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              phone.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              phone.brand,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.65),
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '\$${phone.price.toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => toggleFavorite(phone),
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNav(
        selectedIndex: 2,
      ),
    );
  }
}