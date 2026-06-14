import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const CategoryCard({super.key, required this.icon, required this.title, this.onTap });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),

              color: Colors.white.withValues(alpha: 0.08),

              border: Border.all(color: Colors.white24),
            ),

            child: Icon(icon, size: 36, color: Color(0xFF38BDF8)),
          ),

          const SizedBox(height: 10),

          Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}
