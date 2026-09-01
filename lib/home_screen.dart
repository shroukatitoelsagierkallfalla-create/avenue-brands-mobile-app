import 'package:flutter/material.dart';

import 'search_screen.dart';
import 'profile_screen.dart';
import 'cart_screen.dart';
import 'brand_screen.dart';
import 'zara_screen.dart';
import 'hm_screen.dart';
import 'bershka_screen.dart';

import 'models/product.dart';
import 'models/home_item.dart';
import 'services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<_HomePageData> _homeFuture;

  @override
  void initState() {
    super.initState();

    _homeFuture = _loadHomeData();
  }

  Future<_HomePageData> _loadHomeData() async {
    final products =
        await ApiService.getProducts();

    final homeItems =
        await ApiService.getHomeItems();

    return _HomePageData(
      products: products,
      homeItems: homeItems,
    );
  }

  void _retry() {
    setState(() {
      _homeFuture = _loadHomeData();
    });
  }

  String _normalizeBrand(String value) {
    return value
        .toLowerCase()
        .replaceAll(
          RegExp(r'[^a-z0-9]'),
          '',
        );
  }

  void _openBrand(
    BuildContext context,
    String brand,
  ) {
    final normalized =
        _normalizeBrand(brand);

    if (normalized == 'zara') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const ZaraScreen(),
        ),
      );
      return;
    }

    if (normalized == 'hm') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const HmScreen(),
        ),
      );
      return;
    }

    if (normalized == 'bershka') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const BershkaScreen(),
        ),
      );
      return;
    }

    if (normalized == 'pullbear') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const BrandScreen(),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$brand screen is not available',
        ),
      ),
    );
  }

  List<String> _getUniqueBrands(
    List<Product> products,
  ) {
    final List<String> brands = [];

    for (final product in products) {
      final exists = brands.any(
        (brand) =>
            _normalizeBrand(brand) ==
            _normalizeBrand(product.brand),
      );

      if (!exists &&
          product.brand.trim().isNotEmpty) {
        brands.add(product.brand);
      }
    }

    return brands;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: FutureBuilder<_HomePageData>(
          future: _homeFuture,
          builder: (context, snapshot) {
            // ================= LOADING =================

            if (snapshot.connectionState ==
                ConnectionState.waiting) {
              return const Center(
                child:
                    CircularProgressIndicator(),
              );
            }

            // ================= ERROR =================

            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding:
                      const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 50,
                        color: Colors.red,
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        'Could not load home data',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        snapshot.error.toString(),
                        textAlign:
                            TextAlign.center,
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: _retry,
                        child: const Text(
                          'Try Again',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final data = snapshot.data!;

            final products =
                data.products;

            final homeItems =
                data.homeItems;

            final brands =
                _getUniqueBrands(products);

            // ================= BANNER =================

            final bannerItems =
                homeItems.where(
              (item) =>
                  item.type.toLowerCase() ==
                  'banner',
            );

            if (bannerItems.isEmpty) {
              return const Center(
                child: Text(
                  'Home banner not found in API',
                ),
              );
            }

            final banner =
                bannerItems.first;

            // ================= CATEGORIES =================

            final categories =
                homeItems.where(
              (item) =>
                  item.type.toLowerCase() ==
                  'category',
            ).toList()
                  ..sort(
                    (a, b) =>
                        a.order.compareTo(
                      b.order,
                    ),
                  );

            // ================= TRENDING =================

            final trending =
                homeItems.where(
              (item) =>
                  item.type.toLowerCase() ==
                  'trending',
            ).toList()
                  ..sort(
                    (a, b) =>
                        a.order.compareTo(
                      b.order,
                    ),
                  );

            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(
                        maxWidth: 441,
                      ),

                      child: Column(
                        children: [
                          Expanded(
                            child:
                                SingleChildScrollView(
                              physics:
                                  const BouncingScrollPhysics(),

                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),

                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [
                                    // ================= BANNER FROM API =================

                                    HomeBanner(
                                      banner:
                                          banner,
                                    ),

                                    const SizedBox(
                                      height: 12,
                                    ),

                                    const Text(
                                      'AGGREGATED BRANDS',
                                      style:
                                          TextStyle(
                                        color: Color(
                                          0xFF0057A8,
                                        ),
                                        fontSize: 10,
                                        fontWeight:
                                            FontWeight
                                                .w700,
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 7,
                                    ),

                                    // ================= BRANDS FROM PRODUCTS API =================

                                    SingleChildScrollView(
                                      scrollDirection:
                                          Axis.horizontal,

                                      child: Row(
                                        children:
                                            List.generate(
                                          brands.length,
                                          (index) {
                                            final brand =
                                                brands[
                                                    index];

                                            return Padding(
                                              padding:
                                                  const EdgeInsets
                                                      .only(
                                                right:
                                                    6,
                                              ),

                                              child:
                                                  BrandChip(
                                                brand:
                                                    brand,

                                                onTap:
                                                    () {
                                                  _openBrand(
                                                    context,
                                                    brand,
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 14,
                                    ),

                                    // ================= CATEGORIES FROM API =================

                                    GridView.builder(
                                      shrinkWrap: true,

                                      physics:
                                          const NeverScrollableScrollPhysics(),

                                      itemCount:
                                          categories
                                              .length,

                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            3,
                                        crossAxisSpacing:
                                            10,
                                        mainAxisSpacing:
                                            12,
                                        mainAxisExtent:
                                            90,
                                      ),

                                      itemBuilder:
                                          (
                                        context,
                                        index,
                                      ) {
                                        final category =
                                            categories[
                                                index];

                                        return CategoryItem(
                                          image:
                                              category
                                                  .image,
                                          title:
                                              category
                                                  .title,
                                        );
                                      },
                                    ),

                                    const SizedBox(
                                      height: 14,
                                    ),

                                    // ================= TRENDING HEADER =================

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,

                                      children: [
                                        const Text(
                                          'Trending Now',
                                          style:
                                              TextStyle(
                                            color:
                                                Color(
                                              0xFF0057A8,
                                            ),
                                            fontSize:
                                                11,
                                            fontWeight:
                                                FontWeight
                                                    .w700,
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap:
                                              () {},

                                          child:
                                              const Text(
                                            'View All →',
                                            style:
                                                TextStyle(
                                              color:
                                                  Color(
                                                0xFF0057A8,
                                              ),
                                              fontSize:
                                                  10,
                                              fontWeight:
                                                  FontWeight
                                                      .w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 8,
                                    ),

                                    // ================= TRENDING FROM API =================

                                    if (trending
                                        .isNotEmpty)
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,

                                        children:
                                            List.generate(
                                          trending
                                                      .length >
                                                  2
                                              ? 2
                                              : trending
                                                  .length,
                                          (index) {
                                            final item =
                                                trending[
                                                    index];

                                            return Expanded(
                                              child:
                                                  Padding(
                                                padding:
                                                    EdgeInsets.only(
                                                  right: index ==
                                                          0
                                                      ? 6
                                                      : 0,
                                                  left: index ==
                                                          1
                                                      ? 6
                                                      : 0,
                                                ),

                                                child:
                                                    ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    6,
                                                  ),

                                                  child:
                                                      AspectRatio(
                                                    aspectRatio:
                                                        0.78,

                                                    child:
                                                        Image.asset(
                                                      item.image,
                                                      fit:
                                                          BoxFit.cover,

                                                      errorBuilder:
                                                          (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) {
                                                        return Container(
                                                          color: Colors
                                                              .grey
                                                              .shade200,

                                                          child:
                                                              const Icon(
                                                            Icons.image_not_supported_outlined,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),

                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // ================= BOTTOM NAV =================

                          const HomeBottomNavigation(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ===============================================================
// HOME BANNER
// ===============================================================

class HomeBanner extends StatelessWidget {
  final HomeItem banner;

  const HomeBanner({
    super.key,
    required this.banner,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 441 / 294,

      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(4),

        child: Stack(
          fit: StackFit.expand,

          children: [
            Image.asset(
              banner.image,
              fit: BoxFit.cover,

              errorBuilder:
                  (
                context,
                error,
                stackTrace,
              ) {
                return Container(
                  color:
                      Colors.grey.shade200,

                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                    ),
                  ),
                );
              },
            ),

            Align(
              alignment:
                  Alignment.topLeft,

              child: Padding(
                padding:
                    const EdgeInsets.only(
                  left: 24,
                  top: 66,
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [
                    Text(
                      banner.title,
                      style:
                          const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),

                    const SizedBox(
                      height: 7,
                    ),

                    Text(
                      banner.subtitle,
                      style:
                          const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    const SizedBox(
                      height: 7,
                    ),

                    Text(
                      banner.extraText,
                      style:
                          const TextStyle(
                        color: Color(
                          0xFFB77A54,
                        ),
                        fontSize: 10,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),

                    const SizedBox(
                      height: 13,
                    ),

                    SizedBox(
                      width: 82,
                      height: 31,

                      child:
                          ElevatedButton(
                        onPressed: () {},

                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.white,
                          foregroundColor:
                              Colors.black,
                          elevation: 0,
                          padding:
                              EdgeInsets.zero,

                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              4,
                            ),
                          ),
                        ),

                        child: Text(
                          banner.actionText,

                          style:
                              const TextStyle(
                            fontSize: 8,
                            fontWeight:
                                FontWeight.w700,
                          ),
                        ),
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

// ===============================================================
// BRAND CHIP
// ===============================================================

class BrandChip extends StatelessWidget {
  final String brand;
  final VoidCallback? onTap;

  const BrandChip({
    super.key,
    required this.brand,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        height: 30,

        padding:
            const EdgeInsets.symmetric(
          horizontal: 13,
        ),

        alignment: Alignment.center,

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(16),

          border: Border.all(
            color:
                const Color(0xFFE5E5E5),
            width: 1,
          ),
        ),

        child: Text(
          brand,

          style: const TextStyle(
            fontSize: 8,
            fontWeight:
                FontWeight.w600,
            color:
                Color(0xFF222222),
          ),
        ),
      ),
    );
  }
}

// ===============================================================
// CATEGORY ITEM
// ===============================================================

class CategoryItem extends StatelessWidget {
  final String image;
  final String title;

  const CategoryItem({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: SizedBox(
            width: 58,
            height: 58,

            child: Image.asset(
              image,
              fit: BoxFit.cover,

              errorBuilder:
                  (
                context,
                error,
                stackTrace,
              ) {
                return Container(
                  color:
                      Colors.grey.shade200,

                  child: const Icon(
                    Icons.image_outlined,
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 6),

        Text(
          title,

          textAlign:
              TextAlign.center,

          maxLines: 2,

          overflow:
              TextOverflow.ellipsis,

          style: const TextStyle(
            fontSize: 8,
            color:
                Color(0xFF222222),
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

// ===============================================================
// HOME BOTTOM NAVIGATION
// ===============================================================

class HomeBottomNavigation
    extends StatelessWidget {
  const HomeBottomNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,

      decoration:
          const BoxDecoration(
        color: Colors.white,

        border: Border(
          top: BorderSide(
            color:
                Color(0xFFEDEDED),
            width: 1,
          ),
        ),
      ),

      child: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceAround,

        children: [
          BottomNavItem(
            icon:
                Icons.home_outlined,
            active: true,
            onTap: () {},
          ),

          BottomNavItem(
            icon: Icons.search,

            onTap: () {
              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (context) =>
                      const SearchScreen(),
                ),
              );
            },
          ),

          BottomNavItem(
            icon:
                Icons.compare_arrows,
            onTap: () {},
          ),

          BottomNavItem(
            icon: Icons
                .shopping_cart_outlined,

            onTap: () {
              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (context) =>
                      const CartScreen(),
                ),
              );
            },
          ),

          BottomNavItem(
            icon:
                Icons.person_outline,

            onTap: () {
              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (context) =>
                      const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ===============================================================
// BOTTOM NAV ITEM
// ===============================================================

class BottomNavItem
    extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const BottomNavItem({
    super.key,
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
          mainAxisAlignment:
              MainAxisAlignment
                  .center,

          children: [
            Icon(
              icon,
              size: 20,
              color:
                  const Color(
                0xFF555555,
              ),
            ),

            const SizedBox(
              height: 3,
            ),

            if (active)
              Container(
                width: 4,
                height: 4,

                decoration:
                    const BoxDecoration(
                  color:
                      Color(
                    0xFFC9F36A,
                  ),

                  shape:
                      BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ===============================================================
// HOME PAGE DATA
// ===============================================================

class _HomePageData {
  final List<Product> products;
  final List<HomeItem> homeItems;

  _HomePageData({
    required this.products,
    required this.homeItems,
  });
}