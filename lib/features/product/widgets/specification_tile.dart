import 'package:flutter/material.dart';

/// Expandable spec row — e.g. Display ▼  →  expands to show spec text.
class SpecificationTile extends StatefulWidget {
  final String title;
  final String content;
  final bool initiallyExpanded;

  const SpecificationTile({
    super.key,
    required this.title,
    required this.content,
    this.initiallyExpanded = false,
  });

  @override
  State<SpecificationTile> createState() => _SpecificationTileState();
}

class _SpecificationTileState extends State<SpecificationTile>
    with SingleTickerProviderStateMixin {
  late bool _expanded;
  late AnimationController _ctrl;
  late Animation<double> _rotation;
  late Animation<double> _expand;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
      value: _expanded ? 1.0 : 0.0,
    );
    _rotation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
    _expand = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    _expanded ? _ctrl.forward() : _ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.07)),
      ),
      child: Column(
        children: [
          // Header row
          InkWell(
            onTap: _toggle,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  RotationTransition(
                    turns: _rotation,
                    child: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: Colors.white60, size: 22),
                  ),
                ],
              ),
            ),
          ),

          // Expandable content
          SizeTransition(
            sizeFactor: _expand,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                widget.content,
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 0.55),
                  fontSize: 13,
                  height: 1.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}