import 'package:flutter/material.dart';

/// Shows a row of colour circles. The selected one gets a cyan ring.
class ColorSelector extends StatelessWidget {
  final List<String> colors;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const ColorSelector({
    super.key,
    required this.colors,
    required this.selectedIndex,
    required this.onSelected,
  });

  // Map colour name → actual colour value
  Color _toColor(String name) {
    final n = name.toLowerCase();
    if (n.contains('black') || n.contains('titanium black')) {
      return const Color(0xFF1E293B);
    }
    if (n.contains('white') || n.contains('white titanium')) {
      return const Color(0xFFE2E8F0);
    }
    if (n.contains('blue')) return const Color(0xFF3B82F6);
    if (n.contains('gray') || n.contains('grey')) return const Color(0xFF64748B);
    if (n.contains('violet') || n.contains('purple')) {
      return const Color(0xFF7C3AED);
    }
    if (n.contains('gold') || n.contains('yellow')) {
      return const Color(0xFFFBBF24);
    }
    if (n.contains('red')) return const Color(0xFFEF4444);
    if (n.contains('green')) return const Color(0xFF22C55E);
    return const Color(0xFF94A3B8);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 10,
      children: List.generate(colors.length, (i) {
        final selected = i == selectedIndex;
        return GestureDetector(
          onTap: () => onSelected(i),
          child: Tooltip(
            message: colors[i],
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _toColor(colors[i]),
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? const Color(0xFF38BDF8)
                      : Colors.white.withValues(alpha: 0.12),
                  width: selected ? 2.5 : 1.5,
                ),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF38BDF8).withValues(alpha: 0.45),
                          blurRadius: 8,
                          spreadRadius: 1,
                        )
                      ]
                    : [],
              ),
            ),
          ),
        );
      }),
    );
  }
}