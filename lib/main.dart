import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AvenueApp());
}

class AvenueApp extends StatelessWidget {
  const AvenueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Avenue',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
      ),
      home: const OnboardingScreen(),
    );
  }
}