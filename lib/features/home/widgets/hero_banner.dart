import 'package:flutter/material.dart';

// class HeroBanner extends StatelessWidget {
//   final String imagePath;
//   final String title;
//   final String subtitle;

//   const HeroBanner({
//     super.key,
//     required this.imagePath,
//     required this.title,
//     required this.subtitle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 192,
//       width: 340,
//       margin: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25),
//         gradient: const LinearGradient(
//           colors: [Color(0xff3F51B5), Color(0xff5C6BC0)],
//         ),
//       ),

//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(25),

//         child: Stack(
//           children: [
//             // Background Image
//             Positioned.fill(
//               child: Align(
//                 alignment: Alignment.centerRight,

//                 child: Opacity(
//                   opacity: 0.95,

//                   child: Image.asset(
//                     imagePath,
//                     width: 320,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ),

//             // Dark Overlay
//             Positioned.fill(
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(25),
//                   color: Colors.black.withValues(alpha: 0.45),
//                 ),
//               ),
//             ),
//             // Text Content
//             Padding(
//               padding: const EdgeInsets.all(25),

//               child: SizedBox(
//                 width: 150,

//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       title,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

//                     const SizedBox(height: 6),

//                     Text(
//                       subtitle,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         color: Colors.white70,
//                         fontSize: 14,
//                       ),
//                     ),

//                     const SizedBox(height: 12),

//                     SizedBox(
//                       height: 36,
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         child: const Text("Explore"),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
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
      height: 192,
      width: 340,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        // Optional: Keep gradient as fallback if image fails to load
        gradient: const LinearGradient(
          colors: [Color(0xff3F51B5), Color(0xff5C6BC0)],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          children: [
            //Background Image - fills container completely
            Positioned.fill(
              child: Image.asset(
                imagePath,
                fit: BoxFit
                    .cover, // ← Critical: fills container, crops if needed
                alignment: Alignment.center, // ← Center the image crop
              ),
            ),

            // Dark Overlay - improves text readability
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.black.withValues(alpha: 0.45),
                ),
              ),
            ),

            // Text Content - layered on top via Stack
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
                        height: 1.2, // ← Prevents tight line spacing
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
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 36,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.indigo,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
