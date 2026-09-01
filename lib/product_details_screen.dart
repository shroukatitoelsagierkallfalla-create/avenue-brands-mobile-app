import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String brand;
  final String productName;
  final String price;
  final String imageAsset;
  final double rating;
  final int reviewCount;
  final String description;
  final List<String> sizes;

  const ProductDetailsScreen({
    super.key,
    this.brand = 'PULL&BEAR',
    this.productName = 'RELAXED SWEATSHIRT',
    this.price = '2,250 EGP',
    this.imageAsset = 'assets/images/product.png',
    this.rating = 4.0,
    this.reviewCount = 32,
    this.description =
        'Introducing our sophisticated Relaxed Sweatshirt- the epitome '
        'of style, warmth and timeless elegance',
    this.sizes = const ['S', 'M', 'L', 'XL'],
  });

  @override
  State<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;
  late String selectedSize;
  bool isFavorite = false;
  bool descriptionExpanded = true;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.sizes.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 27),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      // ================= HEADER =================
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              size: 25,
                            ),
                          ),

                          const SizedBox(width: 12),

                          const Text(
                            'Product Details',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Spacer(),

                          const Icon(
                            Icons.notifications_none,
                            size: 27,
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // ================= PRODUCT IMAGE =================
                      Stack(
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.asset(
                                widget.imageAsset,
                                width: 250,
                                height: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Positioned(
                            right: 15,
                            top: -5,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFavorite = !isFavorite;
                                });
                              },
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 27,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // ================= BRAND =================
                      Text(
                        widget.brand,
                        style: const TextStyle(
                          color: Color(0xFF0057A8),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      // ================= PRODUCT NAME =================
                      Text(
                        widget.productName,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // ================= PRICE =================
                      Text(
                        widget.price,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ================= REVIEWS =================
                      Row(
                        children: [
                          Text(
                            'Reviews (${widget.reviewCount})',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const Spacer(),

                          ...List.generate(5, (index) {
                            final starValue = index + 1;
                            return Icon(
                              starValue <= widget.rating.floor()
                                  ? Icons.star
                                  : (starValue - widget.rating < 1 &&
                                          starValue - widget.rating > 0)
                                      ? Icons.star_half
                                      : Icons.star_border,
                              color: const Color(0xFFF2DE83),
                              size: 21,
                            );
                          }),

                          const SizedBox(width: 7),

                          Text(
                            widget.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(width: 10),

                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // ================= DESCRIPTION =================
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            descriptionExpanded = !descriptionExpanded;
                          });
                        },
                        child: Row(
                          children: [
                            const Text(
                              'Description',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const Spacer(),

                            Icon(
                              descriptionExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 30,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 5),

                      if (descriptionExpanded) ...[
                        Text(
                          widget.description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),

                        const Text(
                          'read more ...',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF1A73E8),
                          ),
                        ),
                      ],

                      const SizedBox(height: 12),

                      // ================= SELECT SIZE =================
                      const Text(
                        'Select Size:',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          for (int i = 0; i < widget.sizes.length; i++) ...[
                            if (i > 0) const SizedBox(width: 17),
                            sizeButton(widget.sizes[i]),
                          ],
                        ],
                      ),

                      const SizedBox(height: 14),

                      // ================= QUANTITY =================
                      const Text(
                        'Quantity',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          Container(
                            width: 120,
                            height: 49,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: quantity > 1
                                      ? () {
                                          setState(() {
                                            quantity--;
                                          });
                                        }
                                      : null,
                                  icon: const Icon(
                                    Icons.remove,
                                    size: 17,
                                  ),
                                ),

                                Text(
                                  '$quantity',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      quantity++;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    size: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 8),

                          Expanded(
                            child: SizedBox(
                              height: 49,
                              child: ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${widget.productName} added to cart',
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFFD9F58D),
                                  foregroundColor: Colors.black,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(18),
                                  ),
                                ),
                                child: const Text(
                                  'ADD TO CART',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

            // ================= BOTTOM NAVIGATION =================
            Container(
              height: 60,
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
                          builder: (context) => SearchScreen(),
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
                          builder: (context) => const CartScreen(),
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
                          builder: (context) => const ProfileScreen(),
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

  // ================= SIZE BUTTON =================

  Widget sizeButton(String size) {
    final bool selected = selectedSize == size;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
        });
      },
      child: Container(
        width: 34,
        height: 35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: selected
                ? Colors.black
                : Colors.grey,
            width: selected ? 2 : 1.5,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          size,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}