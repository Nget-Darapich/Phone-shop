import 'package:flutter/material.dart';

class HeroBanner extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const HeroBanner({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [Color(0xff3F51B5), Color(0xff5C6BC0)],
        ),
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),

        child: Stack(
          children: [
            // Background Image
            Positioned(
              right: -40,
              top: 0,
              bottom: 0,
              child: Opacity(
                opacity: 0.9,
                child: Image.asset(
                  imagePath,
                  width: 180,
                  height: 180,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Text Content
            Padding(
              padding: const EdgeInsets.all(25),

              child: SizedBox(
                width: 150,

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      height: 36,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Explore"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
