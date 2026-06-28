import 'package:flutter/material.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/theme/app_colors.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  Widget _reviewCard({required String name, required String text, required String timeAgo, double rating = 5.0}) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(backgroundColor: AppColors.iphoneBlueTitanium, child: Text(name[0], style: const TextStyle(color: Colors.white))),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                        const SizedBox(width: 8),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Color.fromRGBO(34, 197, 94, 0.12), borderRadius: BorderRadius.circular(12)), child: const Text('Verified Buyer', style: TextStyle(color: Color(0xFF22C55E), fontSize: 11))),
                        const Spacer(),
                        Text(timeAgo, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(children: List.generate(5, (i) => Icon(i < rating ? Icons.star_rounded : Icons.star_border_rounded, color: const Color(0xFFFBBF24), size: 14))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('"$text"', style: const TextStyle(color: Colors.white70)),
        ],
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
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
        title: const Text('Customer Reviews', style: TextStyle(color: Colors.white, fontSize: 20)),
        actions: [IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}), IconButton(icon: const Icon(Icons.notifications_outlined, color: Colors.white), onPressed: () {}), IconButton(icon: const Icon(Icons.wb_sunny_outlined, color: Colors.white), onPressed: () {}),],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: const [
                  Text('4.8', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900)),
                  SizedBox(width: 8),
                  Text('★', style: TextStyle(color: Color(0xFFFBBF24), fontSize: 20)),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  children: [
                    _reviewCard(name: 'Alex M.', text: 'Absolutely love the camera on this phone. The battery life is incredible too.', timeAgo: '2 days ago', rating: 5),
                    const SizedBox(height: 12),
                    _reviewCard(name: 'Sarah J.', text: 'Great phone, but a bit heavy. The display is stunning though.', timeAgo: '1 week ago', rating: 4),
                    const SizedBox(height: 12),
                    _reviewCard(name: 'Mike T.', text: 'Upgraded from a 3-year-old phone and the difference is night and day. Highly recommend.', timeAgo: '2 weeks ago', rating: 5),
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
