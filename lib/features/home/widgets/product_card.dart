import 'package:flutter/material.dart';
import '../../../core/router/app_router.dart';
import '../../../data/models/phone_model.dart';

/// Reusable product card — pass any [PhoneModel] and it handles tap → detail.
class ProductCard extends StatelessWidget {
  final PhoneModel phone;

  const ProductCard({super.key, required this.phone});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRouter.product,
        arguments: phone,
      ),
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image + badges ─────────────────────────────────
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset(
                      phone.image,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: const Color(0xFF1E293B),
                        child: const Icon(Icons.phone_android,
                            size: 64, color: Color(0xFF334155)),
                      ),
                    ),
                  ),
                ),

                // NEW badge
                if (phone.isNew)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: _NewBadge(),
                  ),

                // Favourite icon
                Positioned(
                  top: 8,
                  right: 8,
                  child: _CircleIcon(
                    icon: Icons.favorite_border_rounded,
                    onTap: () {},
                  ),
                ),
              ],
            ),

            // ── Info ────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    phone.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    phone.brand,
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.45), fontSize: 12),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${phone.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded,
                              color: Color(0xFFFBBF24), size: 15),
                          const SizedBox(width: 3),
                          Text(
                            phone.rating.toString(),
                            style: const TextStyle(
                              color: Color(0xFFFBBF24),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Private helpers ───────────────────────────────────────────────────────────

class _NewBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF38BDF8), Color(0xFF0EA5E9)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: const Color(0xFF0EA5E9).withValues(alpha: 0.4),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: const Text('NEW',
          style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6)),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.35),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 17),
      ),
    );
  }
}