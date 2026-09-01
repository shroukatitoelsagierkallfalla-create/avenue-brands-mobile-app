import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'search_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'hm_product_details_screen.dart';

import 'models/product.dart';
import 'services/api_service.dart';

class HmScreen extends StatelessWidget {
  const HmScreen({super.key});

  String formatPrice(double price) {
    final number = price.toInt().toString();

    final result = number.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );

    return '$result EGP';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'H&M',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // ================= H&M LOGO =================
            Image.asset(
              'assets/images/hmlogo.png',
              height: 55,
            ),

            // ================= DESCRIPTION =================
            const Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Explore the latest collection',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            // ================= CATEGORIES =================
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                children: [
                  category('Women', false),
                  category('Men', true),
                  category('Shoes', false),
                  category('Accessories', false),
                  category('Beauty', false),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // ================= PRODUCTS FROM API =================
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: ApiService.getProductsByBrand('H&M'),
                builder: (context, snapshot) {
                  // Loading
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // Error
                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 45,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Could not load products',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              snapshot.error.toString(),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final products = snapshot.data ?? [];

                  if (products.isEmpty) {
                    return const Center(
                      child: Text('No products found'),
                    );
                  }

                  return Column(
                    children: [
                      // ================= PRODUCT COUNT =================
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${products.length} Products',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // ================= PRODUCT GRID =================
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(25),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: .7,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HmProductDetailsScreen(
                                      brand: product.brand,
                                      productName: product.name,
                                      price:
                                          formatPrice(product.price),
                                      imageAsset: product.image,
                                      rating: product.rating,
                                      reviewCount:
                                          product.reviews,
                                      description:
                                          product.description,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(16),
                                  side: BorderSide(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(
                                            12,
                                          ),
                                          child: Image.asset(
                                            product.image,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 6),

                                      Text(
                                        product.brand,
                                        style: const TextStyle(
                                          color: Color(
                                            0xFF0066B3,
                                          ),
                                          fontWeight:
                                              FontWeight.bold,
                                          fontSize: 11,
                                        ),
                                      ),

                                      Text(
                                        product.name,
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),

                                      Text(
                                        formatPrice(
                                          product.price,
                                        ),
                                        style: const TextStyle(
                                          fontWeight:
                                              FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // ================= BOTTOM NAVIGATION =================
            Container(
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
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const HomeScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Icon(
                      Icons.home_outlined,
                      color: Color(0xFF555555),
                      size: 20,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SearchScreen(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.search,
                      color: Color(0xFF555555),
                      size: 20,
                    ),
                  ),

                  const Icon(
                    Icons.account_tree_outlined,
                    color: Color(0xFF555555),
                    size: 20,
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const CartScreen(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Color(0xFF555555),
                      size: 20,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ProfileScreen(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.person_outline,
                      color: Color(0xFF555555),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget category(String name, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
      ),
      decoration: BoxDecoration(
        color: selected
            ? const Color(0xFFD9F58F)
            : Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(name),
      ),
    );
  }
}