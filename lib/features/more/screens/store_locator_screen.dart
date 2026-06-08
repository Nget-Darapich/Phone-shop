import 'package:flutter/material.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/theme/app_colors.dart';

class StoreLocatorScreen extends StatelessWidget {
  const StoreLocatorScreen({super.key});

  Widget _storeCard({
    required String name,
    required String address,
    required String distance,
    required bool primary,
  }) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text(address, style: const TextStyle(color: Colors.white54, fontSize: 13)),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(distance, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F172A),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text('Directions', style: TextStyle(color: Colors.white70)),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary ? AppColors.cyan400 : const Color(0xFF0F172A),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: Text('Book Visit', style: TextStyle(color: primary ? Colors.black : Colors.white70)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate950,
      appBar: AppBar(
        backgroundColor: AppColors.slate950,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Store Locator', style: TextStyle(color: Colors.white, fontSize: 20)),
        actions: [
          IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications_outlined, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.wb_sunny_outlined, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Our Stores', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800)),
              const SizedBox(height: 20),
              _storeCard(
                name: 'Downtown Flagship',
                address: '123 Tech Ave, City Center',
                distance: '1.2 mi',
                primary: true,
              ),
              const SizedBox(height: 12),
              _storeCard(
                name: 'Westside Mall',
                address: '456 Retail Blvd, Westside',
                distance: '3.5 mi',
                primary: false,
              ),
              const SizedBox(height: 12),
              _storeCard(
                name: 'North Park Plaza',
                address: '789 Park St, Northside',
                distance: '5.1 mi',
                primary: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
