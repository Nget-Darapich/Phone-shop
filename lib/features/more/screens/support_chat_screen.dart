import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({super.key});

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'text': "Hi there! I'm your virtual assistant. How can I help today?", 'sentByMe': false},
    {'text': 'I want to know if the iPhone 15 Pro is in stock.', 'sentByMe': true},
    {'text': 'Let me check that for you. Yes, we currently have a few units available.', 'sentByMe': false},
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add({'text': text, 'sentByMe': true});
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.slate950,
      appBar: AppBar(
        backgroundColor: AppColors.slate950,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
        title: const Text('Support Chat', style: TextStyle(color: Colors.white, fontSize: 20)),
        actions: [
          IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.notifications_outlined, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.wb_sunny_outlined, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(color: Color(0xFF0F172A), shape: BoxShape.circle),
                    child: const Icon(Icons.support_agent_rounded, color: AppColors.cyan400),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Support Chat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                      SizedBox(height: 4),
                      Text('Online', style: TextStyle(color: Color(0xFF22C55E), fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final sentByMe = message['sentByMe'] as bool;
                  return Align(
                    alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: sentByMe ? const Color(0xFF2563EB) : const Color(0xFF111827),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(18),
                          topRight: const Radius.circular(18),
                          bottomLeft: Radius.circular(sentByMe ? 18 : 4),
                          bottomRight: Radius.circular(sentByMe ? 4 : 18),
                        ),
                      ),
                      child: Text(
                        message['text'] as String,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(color: Colors.white38),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send_rounded, color: AppColors.cyan400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
