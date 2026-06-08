import 'package:flutter/material.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/theme/app_colors.dart';

class RepairTrackerScreen extends StatelessWidget {
  const RepairTrackerScreen({super.key});

  Widget _buildStep({required String label, required String subtitle, required bool completed, bool active = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: completed ? AppColors.cyan400 : Colors.transparent,
                border: Border.all(color: completed ? AppColors.cyan400 : Colors.white24),
                shape: BoxShape.circle,
              ),
            ),
            Container(width: 2, height: 60, color: Colors.white12),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: completed ? Colors.white : Colors.white70, fontWeight: active ? FontWeight.w700 : FontWeight.w600)),
              const SizedBox(height: 6),
              Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 12)),
            ],
          ),
        ),
      ],
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
        title: const Text('Repair Tracker', style: TextStyle(color: Colors.white, fontSize: 20)),
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
            children: [
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('iPhone 14 Screen Replacement', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                            SizedBox(height: 6),
                            Text('Ticket #REP-8492', style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(34, 197, 94, 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text('In Progress', style: TextStyle(color: Color(0xFF22C55E), fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: Colors.white12),
                    const SizedBox(height: 12),
                    _buildStep(label: 'Received', subtitle: 'Oct 12, 10:00 AM', completed: true),
                    const SizedBox(height: 12),
                    _buildStep(label: 'Diagnosis', subtitle: 'Oct 12, 2:30 PM', completed: true),
                    const SizedBox(height: 12),
                    _buildStep(label: 'Repair in Progress', subtitle: 'Oct 13, 9:15 AM', completed: true, active: true),
                    const SizedBox(height: 12),
                    _buildStep(label: 'Ready for Pickup', subtitle: 'Pending', completed: false),
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
