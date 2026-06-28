import 'package:flutter/material.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_bottom_nav.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: const CustomBottomNav(selectedIndex: 4),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Profile', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 12),
              Text('This page is a placeholder for the user profile section.'),
            ],
          ),
        ),
      ),
    );
  }
}
