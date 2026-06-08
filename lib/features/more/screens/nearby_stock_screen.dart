import 'package:flutter/material.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/theme/app_colors.dart';

class NearbyStockScreen extends StatelessWidget {
  const NearbyStockScreen({super.key});

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
        title: const Text('Nearby Stock', style: TextStyle(color: Colors.white, fontSize: 20)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
              )
            ],
          ),
          IconButton(
            icon: const Icon(Icons.wb_sunny_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Search field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B1220),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Colors.grey),
                    hintText: 'Search nearby stores',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // List of stores
              Expanded(
                child: ListView(
                  children: const [
                    _StoreCard(
                      name: 'Downtown Flagship',
                      address: '123 Tech Ave, City Center',
                      distance: '1.2 m away',
                      status: 'Low Stock',
                      statusColor: AppColors.warning,
                    ),
                    SizedBox(height: 12),
                    _StoreCard(
                      name: 'Westside Mall',
                      address: '456 Retail Blvd, Westside',
                      distance: '3.5 m away',
                      status: 'In Stock',
                      statusColor: AppColors.success,
                    ),
                    SizedBox(height: 12),
                    _StoreCard(
                      name: 'North Park Plaza',
                      address: '789 Park St, Northside',
                      distance: '5.1 m away',
                      status: 'Out of Stock',
                      statusColor: AppColors.error,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StoreCard extends StatelessWidget {
  final String name;
  final String address;
  final String distance;
  final String status;
  final Color statusColor;

  const _StoreCard({
    required this.name,
    required this.address,
    required this.distance,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF06202B),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.location_on, color: AppColors.cyan400),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(address, style: const TextStyle(color: AppColors.textSecondaryDark, fontSize: 13)),
                const SizedBox(height: 6),
                Text(distance, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                child: const Text('Reserve Unit', style: TextStyle(color: AppColors.cyan400)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
