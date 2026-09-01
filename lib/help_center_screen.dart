import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  static const List<Map<String, String>> _faqs = [
    {
      'q': 'How do I track my order?',
      'a': 'Go to Home > Orders to see real-time status for every order '
          'you have placed.',
    },
    {
      'q': 'How do I return an item?',
      'a': 'Open the order in Orders, tap "Return Item", and follow the '
          'prompts. Returns are free within 30 days.',
    },
    {
      'q': 'How do I change my payment method?',
      'a': 'Go to Settings > Personal Information to update your saved '
          'payment details.',
    },
    {
      'q': 'How do I contact support?',
      'a': 'Tap "Contact Us" below or email support@avenue.app and we will '
          'get back to you within 24 hours.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF0066B3),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Help Center',
          style: TextStyle(
            color: Color(0xFFC9F36A),
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        children: [
          ..._faqs.map(
            (faq) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE0E0E0)),
                borderRadius: BorderRadius.circular(9),
              ),
              child: ExpansionTile(
                title: Text(
                  faq['q']!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                childrenPadding:
                    const EdgeInsets.fromLTRB(16, 0, 16, 14),
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    faq['a']!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF555555),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Opening contact form...'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0066B3),
                foregroundColor: const Color(0xFFC9F36A),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: const Text(
                'Contact Us',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}