import 'package:flutter/material.dart';

class BrandCircle extends StatelessWidget {
  final String brand;
  final VoidCallback onTap;

  const BrandCircle({super.key, required this.brand, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            child: Text(
              brand[0],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Text(brand, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
