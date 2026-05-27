import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {

  final Widget child;

  const GlassCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: EdgeInsets.all(16),

      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(20),

        gradient: LinearGradient(
          colors: [
            Color(0xFF1E293B),
            Color(0xFF111827),
          ],
        ),

        border: Border.all(
          color: Colors.white24,
        ),
      ),

      child: child,
    );
  }
}