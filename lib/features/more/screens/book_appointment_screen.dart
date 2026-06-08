import 'package:flutter/material.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/theme/app_colors.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  bool _storePickup = true;
  int _selectedBranch = 0;

  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Widget _buildBranchTile(String title, String subtitle, int index) {
    final selected = _selectedBranch == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedBranch = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF111827) : const Color(0xFF0F172A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: selected ? AppColors.cyan400 : Colors.white12),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: selected ? AppColors.cyan400 : Colors.white30, width: 2),
                color: selected ? AppColors.cyan400 : Colors.transparent,
              ),
              child: selected
                  ? const Center(
                      child: Icon(Icons.check, size: 12, color: Colors.black),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
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
        title: const Text('Book Appointment', style: TextStyle(color: Colors.white, fontSize: 20)),
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
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Column(
                    children: [
                      GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                _buildSegmentButton('Store Pickup', _storePickup),
                                const SizedBox(width: 12),
                                _buildSegmentButton('Repair Service', !_storePickup),
                              ],
                            ),
                            const SizedBox(height: 24),
                            const Text('Select Branch', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 16),
                            _buildBranchTile('Downtown Flagship', '1.2 mi away', 0),
                            const SizedBox(height: 12),
                            _buildBranchTile('Westside Mall', '3.5 mi away', 1),
                            const SizedBox(height: 12),
                            _buildBranchTile('North Park Plaza', '5.1 mi away', 2),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(child: _buildSmallInput('Date')),
                          const SizedBox(width: 12),
                          Expanded(child: _buildSmallInput('Time', icon: Icons.access_time)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      GlassCard(
                        child: TextField(
                          controller: _notesController,
                          minLines: 4,
                          maxLines: 6,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Describe your issue or request...',
                            hintStyle: TextStyle(color: Colors.white38),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cyan400,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 0,
                  ),
                  child: const Text('Confirm Booking', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSegmentButton(String label, bool active) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _storePickup = label == 'Store Pickup'),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: active ? const Color(0xFF1F2937) : const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: active ? AppColors.cyan400 : Colors.white12),
          ),
          child: Center(
            child: Text(label, style: TextStyle(color: active ? Colors.white : Colors.white54, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }

  Widget _buildSmallInput(String label, {IconData? icon}) {
    return GlassCard(
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          ),
          if (icon != null) Icon(icon, color: Colors.cyanAccent, size: 20),
        ],
      ),
    );
  }
}
