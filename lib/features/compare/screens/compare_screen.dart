import 'package:flutter/material.dart';
import '../../../core/widgets/custom_bottom_nav.dart';
import '../../../data/models/phone_model.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const Text('Compare Phones'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(selectedIndex: 1),
      body: ValueListenableBuilder<Set<String>>(
        valueListenable: compareIdsNotifier,
        builder: (context, compareIds, _) {
          final items = comparePhones();
          if (items.isEmpty) {
            return const SafeArea(
              child: Center(
                child: Text('No items to compare yet', style: TextStyle(color: Colors.white)),
              ),
            );
          }

          return SafeArea(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final phone = items[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F172A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color.fromRGBO(255, 255, 255, 0.08)),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: Image.asset(phone.image, fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) {
                            return const Icon(Icons.phone_android, color: Colors.white30, size: 48);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(phone.name,
                                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text(phone.brand,
                                style: const TextStyle(color: Color(0xFF38BDF8), fontSize: 12, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 12),
                            Text(phone.description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          toggleCompare(phone);
                        },
                        icon: const Icon(Icons.close, color: Colors.white70),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemCount: items.length,
            ),
          );
        },
      ),
    );
  }
}
