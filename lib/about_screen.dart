import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
          'About Avenue',
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
          Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 80,
            ),
          ),

          const SizedBox(height: 8),

          const Center(
            child: Text(
              'The mall, in your pocket.',
              style: TextStyle(fontSize: 12, color: Color(0xFF777777)),
            ),
          ),

          const SizedBox(height: 30),

          _infoRow('Version', '1.0.0'),
          _infoRow('Build', '1.134.0'),

          const SizedBox(height: 30),

          const Text(
            'ABOUT',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0066B3),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Avenue brings the mall experience to your phone. Browse '
            'trending styles, track your orders, and shop your favorite '
            'brands all in one place, wherever you are.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF444444),
              height: 1.5,
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'CONTACT',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0066B3),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'support@avenue.app',
            style: TextStyle(fontSize: 13, color: Color(0xFF444444)),
          ),

          const SizedBox(height: 30),

          const Center(
            child: Text(
              '© 2026 Avenue. All rights reserved.',
              style: TextStyle(fontSize: 11, color: Color(0xFF999999)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111111),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 13, color: Color(0xFF777777)),
          ),
        ],
      ),
    );
  }
}