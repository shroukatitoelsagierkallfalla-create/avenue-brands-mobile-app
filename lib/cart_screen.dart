import 'package:flutter/material.dart';
import 'product_details_screen.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'profile_screen.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [

            // ================= HEADER =================
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 20,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),

                  const Spacer(),

                  const Text(
                    'CART',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF403536),
                    ),
                  ),

                  const Spacer(),

                  const SizedBox(width: 48),
                ],
              ),
            ),

            // ================= CONTENT =================
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    // ================= FREE SHIPPING =================
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 3,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD9F58D),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              FractionallySizedBox(
                                widthFactor: 0.72,
                                child: Container(
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0874C9),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),

                              Positioned(
                                left: 180,
                                top: -5,
                                child: Container(
                                  width: 13,
                                  height: 13,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF0874C9),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          const Text(
                            'Spend EGP 200.00 more and get free shipping',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ================= PRODUCT HEADER =================
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 42),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD9F58D),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              'PRODUCT:',
                              style: TextStyle(
                                color: Color(0xFF0874C9),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),

                          const Spacer(),

                          const Text(
                            'Quantity',
                            style: TextStyle(
                              color: Color(0xFF0069C9),
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(width: 30),

                          const Text(
                            'Total',
                            style: TextStyle(
                              color: Color(0xFF0069C9),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ================= GREEN DIVIDER =================
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 46),
                      height: 1,
                      color: const Color(0xFFD9F58D),
                    ),

                    const SizedBox(height: 10),

                    // ================= PRODUCT 1 =================
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 46,
                        vertical: 5,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ProductDetailsScreen(),
                            ),
                          );
                        },
                        child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(
                            width: 78,
                            height: 110,
                            child: Image.asset(
                              'assets/images/top.png',
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(width: 8),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'PULL & BEAR',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),

                                Text(
                                  'Thin strap top',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text(
                                  'LE 490.00',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),

                                Text(
                                  'S',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Column(
                            children: [
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFD9F58D),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  '1',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 5),

                              const Text(
                                'Remove',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF0069C9),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(width: 8),

                          const Text(
                            'LE 490.00',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                        ),
                      ),
                    ),

                    // ================= PRODUCT 2 =================
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 46,
                        vertical: 5,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox(
                            width: 78,
                            height: 110,
                            child: Image.asset(
                              'assets/images/hair_bands.png',
                              fit: BoxFit.cover,
                            ),
                          ),

                          const SizedBox(width: 8),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'BERSHKA',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),

                                Text(
                                  '2 studded hair bands',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text(
                                  'LE 850.00',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),

                                Text(
                                  'one size',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Column(
                            children: [
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFD9F58D),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  '1',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 5),

                              const Text(
                                'Remove',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF0069C9),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(width: 8),

                          const Text(
                            'LE 850.00',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ================= TOTAL =================
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 34),
                      padding: const EdgeInsets.all(14),
                      color: const Color(0xFFF5F5F5),
                      child: Column(
                        children: [

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'SUB-TOTAL',
                                style: TextStyle(
                                  color: Color(0xFF0069C9),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),

                              Text(
                                'LE 1,340.00',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 4),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'TOTAL',
                                style: TextStyle(
                                  color: Color(0xFF0069C9),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Text(
                                'LE 1,340.00 EGP',
                              ),
                            ],
                          ),

                          const SizedBox(height: 28),

                          const Text(
                            'Taxes and shipping calculated at checkout',
                            style: TextStyle(
                              color: Color(0xFF0069C9),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ================= CHECKOUT =================
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CheckoutScreen(total: 1340.00),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD9F58D),
                            foregroundColor: const Color(0xFF0069C9),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.lock,
                                size: 17,
                              ),

                              SizedBox(width: 5),

                              Text(
                                'CHECKOUT',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ================= BOTTOM NAVIGATION =================
      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFEDEDED),
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _CartNavItem(
              icon: Icons.home_outlined,
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                  (route) => false,
                );
              },
            ),

            _CartNavItem(
              icon: Icons.search,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ),
                );
              },
            ),

            _CartNavItem(
              icon: Icons.account_tree_outlined,
              onTap: () {},
            ),

            _CartNavItem(
              icon: Icons.shopping_cart_outlined,
              active: true,
              onTap: () {},
            ),

            _CartNavItem(
              icon: Icons.person_outline,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ================= NAV ITEM (matches Home's style) =================

class _CartNavItem extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const _CartNavItem({
    required this.icon,
    this.active = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 48,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: const Color(0xFF555555),
            ),
            const SizedBox(height: 3),
            if (active)
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Color(0xFFC9F36A),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
