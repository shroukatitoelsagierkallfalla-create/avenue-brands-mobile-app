import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'profile_screen.dart';
import 'cart_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F7),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 430),
            color: Colors.white,
            child: Column(
              children: [

                // Back button
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                const SizedBox(height: 70),

                // Check mark
                const Icon(
                  Icons.check,
                  size: 100,
                  color: Color(0xFF0862AE),
                ),

                const SizedBox(height: 30),

                // Text
                const Text(
                  'Plans tonight? Outfit handled.',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                const Text(
                  'The outfit is officially en route!!!',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 5),

                const Text(
                  'THANK YOU.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                // Temporary logo
                const Text(
                  'Avenue',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0862AE),
                  ),
                ),

                const Spacer(),

                // Track Shipment
                button(
                  'TRACK SHIPMENT',
                  const Color(0xFF0862AE),
                  Colors.white,
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Your shipment is on the way!'),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 10),

                // Back to Home
                button(
                  'BACK TO HOME',
                  const Color(0xFFD9F58F),
                  const Color(0xFF0862AE),
                  () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),

                const SizedBox(height: 25),

                // Bottom navigation
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Icon(Icons.home_outlined),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchScreen(),
                            ),
                          );
                        },
                        child: const Icon(Icons.search),
                      ),
                      const Icon(Icons.account_tree_outlined),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartScreen(),
                            ),
                          );
                        },
                        child: const Icon(Icons.shopping_cart_outlined),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        },
                        child: const Icon(Icons.person_outline),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget button(
    String text,
    Color background,
    Color textColor,
    VoidCallback action,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          onPressed: action,
          style: ElevatedButton.styleFrom(
            backgroundColor: background,
            foregroundColor: textColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}