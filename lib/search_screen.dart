import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'profile_screen.dart';
import 'cart_screen.dart';

import 'zara_screen.dart';
import 'hm_screen.dart';
import 'bershka_screen.dart';
import 'brand_screen.dart';

import 'zara_product_details_screen.dart';
import 'hm_product_details_screen.dart';
import 'bershka_product_details_screen.dart';
import 'product_details_screen.dart';

import 'models/product.dart';
import 'services/api_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() =>
      _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController =
      TextEditingController();

  late Future<List<Product>> _productsFuture;

  // These are NOT hardcoded data.
  // They start empty and are filled by the user's searches.
  final List<String> recentSearches = [];

  @override
  void initState() {
    super.initState();

    _productsFuture =
        ApiService.getProducts();

    searchController.addListener(
      _onSearchChanged,
    );
  }

  @override
  void dispose() {
    searchController.removeListener(
      _onSearchChanged,
    );

    searchController.dispose();

    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {});
  }

  // =====================================================
  // NORMALIZE BRAND
  // =====================================================

  String _normalizeBrand(String value) {
    return value
        .toLowerCase()
        .replaceAll(
          RegExp(r'[^a-z0-9]'),
          '',
        );
  }

  // =====================================================
  // FORMAT PRICE
  // =====================================================

  String formatPrice(double price) {
    final number =
        price.toInt().toString();

    final result =
        number.replaceAllMapped(
      RegExp(
        r'(\d)(?=(\d{3})+(?!\d))',
      ),
      (match) => '${match[1]},',
    );

    return '$result EGP';
  }

  // =====================================================
  // SEARCH PRODUCTS
  // =====================================================

  List<Product> _filterProducts(
    List<Product> products,
  ) {
    final query = searchController.text
        .trim()
        .toLowerCase();

    if (query.isEmpty) {
      return [];
    }

    return products.where(
      (product) {
        return product.name
                .toLowerCase()
                .contains(query) ||
            product.brand
                .toLowerCase()
                .contains(query) ||
            product.category
                .toLowerCase()
                .contains(query) ||
            product.color
                .toLowerCase()
                .contains(query) ||
            product.gender
                .toLowerCase()
                .contains(query);
      },
    ).toList();
  }

  // =====================================================
  // ADD RECENT SEARCH
  // =====================================================

  void _submitSearch(String value) {
    final query = value.trim();

    if (query.isEmpty) {
      return;
    }

    setState(() {
      recentSearches.removeWhere(
        (item) =>
            item.toLowerCase() ==
            query.toLowerCase(),
      );

      recentSearches.insert(
        0,
        query,
      );

      // Keep only the latest 3 searches.
      if (recentSearches.length > 3) {
        recentSearches.removeLast();
      }
    });
  }

  // =====================================================
  // UNIQUE BRANDS FROM API
  // =====================================================

  List<String> _getBrands(
    List<Product> products,
  ) {
    final List<String> brands = [];

    for (final product in products) {
      if (product.brand.trim().isEmpty) {
        continue;
      }

      final exists = brands.any(
        (brand) =>
            _normalizeBrand(brand) ==
            _normalizeBrand(
              product.brand,
            ),
      );

      if (!exists) {
        brands.add(
          product.brand,
        );
      }
    }

    return brands;
  }

  // =====================================================
  // CATEGORIES FROM API
  // =====================================================

  List<String> _getCategories(
    List<Product> products,
  ) {
    final List<String> categories = [];

    for (final product in products) {
      final category =
          product.category.trim();

      if (category.isEmpty) {
        continue;
      }

      final exists = categories.any(
        (item) =>
            item.toLowerCase() ==
            category.toLowerCase(),
      );

      if (!exists) {
        categories.add(category);
      }
    }

    // Keep the design compact.
    if (categories.length > 6) {
      return categories
          .take(6)
          .toList();
    }

    return categories;
  }

  // =====================================================
  // OPEN BRAND
  // =====================================================

  void _openBrand(
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
  }

  // =====================================================
  // OPEN PRODUCT DETAILS
  // =====================================================

  void _openProduct(
    Product product,
  ) {
    final normalized =
        _normalizeBrand(
      product.brand,
    );

    if (normalized == 'zara') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ZaraProductDetailsScreen(
            brand: product.brand,
            productName: product.name,
            price:
                formatPrice(product.price),
            imageAsset:
                product.image,
            rating:
                product.rating,
            reviewCount:
                product.reviews,
            description:
                product.description,
          ),
        ),
      );

      return;
    }

    if (normalized == 'hm') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              HmProductDetailsScreen(
            brand: product.brand,
            productName: product.name,
            price:
                formatPrice(product.price),
            imageAsset:
                product.image,
            rating:
                product.rating,
            reviewCount:
                product.reviews,
            description:
                product.description,
          ),
        ),
      );

      return;
    }

    if (normalized == 'bershka') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BershkaProductDetailsScreen(
            brand: product.brand,
            productName: product.name,
            price:
                formatPrice(product.price),
            imageAsset:
                product.image,
            rating:
                product.rating,
            reviewCount:
                product.reviews,
            description:
                product.description,
            sizes: const [
              '35',
              '36',
              '37',
              '38',
              '39',
              '40',
              '41',
            ],
          ),
        ),
      );

      return;
    }

    if (normalized == 'pullbear') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ProductDetailsScreen(
            brand: product.brand,
            productName: product.name,
            price:
                formatPrice(product.price),
            imageAsset:
                product.image,
            rating:
                product.rating,
            reviewCount:
                product.reviews,
            description:
                product.description,
          ),
        ),
      );
    }
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF7F8FA),

      body: SafeArea(
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
                      FutureBuilder<List<Product>>(
                    future:
                        _productsFuture,

                    builder:
                        (context, snapshot) {
                      // ================= LOADING =================

                      if (snapshot
                              .connectionState ==
                          ConnectionState
                              .waiting) {
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
                                const EdgeInsets
                                    .all(
                              30,
                            ),

                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,

                              children: [
                                const Icon(
                                  Icons
                                      .error_outline,
                                  size: 45,
                                  color:
                                      Colors.red,
                                ),

                                const SizedBox(
                                  height: 10,
                                ),

                                const Text(
                                  'Could not load search data',
                                  style:
                                      TextStyle(
                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                Text(
                                  snapshot.error
                                      .toString(),
                                  textAlign:
                                      TextAlign
                                          .center,
                                ),

                                const SizedBox(
                                  height: 20,
                                ),

                                ElevatedButton(
                                  onPressed: () {
                                    setState(
                                      () {
                                        _productsFuture =
                                            ApiService
                                                .getProducts();
                                      },
                                    );
                                  },
                                  child:
                                      const Text(
                                    'Try Again',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      final products =
                          snapshot.data ??
                              [];

                      final brands =
                          _getBrands(
                        products,
                      );

                      final popularSearches =
                          _getCategories(
                        products,
                      );

                      final searchResults =
                          _filterProducts(
                        products,
                      );

                      final isSearching =
                          searchController
                              .text
                              .trim()
                              .isNotEmpty;

                      return Container(
                        color:
                            Colors.white,

                        child:
                            SingleChildScrollView(
                          physics:
                              const BouncingScrollPhysics(),

                          child: Padding(
                            padding:
                                const EdgeInsets
                                    .symmetric(
                              horizontal: 18,
                            ),

                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,

                              children: [
                                const SizedBox(
                                  height: 26,
                                ),

                                // ================= BACK =================

                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(
                                      context,
                                    );
                                  },

                                  child:
                                      const Icon(
                                    Icons
                                        .arrow_back,
                                    size: 21,
                                    color: Color(
                                      0xFF111111,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 8,
                                ),

                                const Text(
                                  'Search',
                                  style:
                                      TextStyle(
                                    color:
                                        Color(
                                      0xFF111111,
                                    ),
                                    fontSize:
                                        17,
                                    fontWeight:
                                        FontWeight
                                            .w600,
                                  ),
                                ),

                                const SizedBox(
                                  height: 12,
                                ),

                                // ================= SEARCH FIELD =================

                                Container(
                                  height: 42,

                                  decoration:
                                      BoxDecoration(
                                    color:
                                        Colors.white,

                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      22,
                                    ),

                                    boxShadow:
                                        const [
                                      BoxShadow(
                                        color:
                                            Color(
                                          0x12000000,
                                        ),
                                        blurRadius:
                                            12,
                                        offset:
                                            Offset(
                                          0,
                                          4,
                                        ),
                                      ),
                                    ],
                                  ),

                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 15,
                                      ),

                                      const Icon(
                                        Icons
                                            .search,
                                        size: 18,
                                        color:
                                            Color(
                                          0xFF222222,
                                        ),
                                      ),

                                      const SizedBox(
                                        width: 10,
                                      ),

                                      Expanded(
                                        child:
                                            TextField(
                                          controller:
                                              searchController,

                                          onSubmitted:
                                              _submitSearch,

                                          style:
                                              const TextStyle(
                                            fontSize:
                                                10,
                                            color:
                                                Color(
                                              0xFF222222,
                                            ),
                                          ),

                                          decoration:
                                              const InputDecoration(
                                            hintText:
                                                'Search products, brands...',

                                            hintStyle:
                                                TextStyle(
                                              fontSize:
                                                  9,
                                              color:
                                                  Color(
                                                0xFF888888,
                                              ),
                                            ),

                                            border:
                                                InputBorder.none,

                                            isDense:
                                                true,
                                          ),
                                        ),
                                      ),

                                      // CLEAR SEARCH
                                      if (isSearching)
                                        GestureDetector(
                                          onTap: () {
                                            searchController
                                                .clear();
                                          },

                                          child:
                                              const Padding(
                                            padding:
                                                EdgeInsets
                                                    .symmetric(
                                              horizontal:
                                                  8,
                                            ),
                                            child:
                                                Icon(
                                              Icons
                                                  .close,
                                              size:
                                                  16,
                                              color:
                                                  Color(
                                                0xFF555555,
                                              ),
                                            ),
                                          ),
                                        )
                                      else
                                        Container(
                                          width: 23,
                                          height: 23,

                                          margin:
                                              const EdgeInsets
                                                  .only(
                                            right:
                                                10,
                                          ),

                                          decoration:
                                              const BoxDecoration(
                                            color:
                                                Color(
                                              0xFFC9F36A,
                                            ),
                                            shape:
                                                BoxShape.circle,
                                          ),

                                          child:
                                              const Icon(
                                            Icons
                                                .camera_alt_outlined,
                                            size:
                                                14,
                                            color:
                                                Color(
                                              0xFF1670A8,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  height: 20,
                                ),

                                // ============================================
                                // SEARCH RESULTS
                                // ============================================

                                if (isSearching) ...[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,

                                    children: [
                                      const Text(
                                        'Search Results',
                                        style:
                                            TextStyle(
                                          fontSize:
                                              10,
                                          fontWeight:
                                              FontWeight
                                                  .w700,
                                          color:
                                              Color(
                                            0xFF222222,
                                          ),
                                        ),
                                      ),

                                      Text(
                                        '${searchResults.length} found',
                                        style:
                                            const TextStyle(
                                          fontSize:
                                              8,
                                          color:
                                              Color(
                                            0xFF777777,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 12,
                                  ),

                                  if (searchResults
                                      .isEmpty)
                                    const Padding(
                                      padding:
                                          EdgeInsets
                                              .symmetric(
                                        vertical:
                                            40,
                                      ),

                                      child:
                                          Center(
                                        child:
                                            Text(
                                          'No matching products found',
                                          style:
                                              TextStyle(
                                            fontSize:
                                                11,
                                            color:
                                                Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),

                                  ...searchResults.map(
                                    (product) {
                                      return GestureDetector(
                                        onTap:
                                            () {
                                          _submitSearch(
                                            searchController
                                                .text,
                                          );

                                          _openProduct(
                                            product,
                                          );
                                        },

                                        child:
                                            Container(
                                          margin:
                                              const EdgeInsets
                                                  .only(
                                            bottom:
                                                12,
                                          ),

                                          padding:
                                              const EdgeInsets
                                                  .all(
                                            8,
                                          ),

                                          decoration:
                                              BoxDecoration(
                                            color:
                                                Colors.white,

                                            borderRadius:
                                                BorderRadius
                                                    .circular(
                                              12,
                                            ),

                                            border:
                                                Border.all(
                                              color:
                                                  const Color(
                                                0xFFEDEDED,
                                              ),
                                            ),
                                          ),

                                          child:
                                              Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                  8,
                                                ),

                                                child:
                                                    Image.asset(
                                                  product.image,
                                                  width:
                                                      62,
                                                  height:
                                                      70,
                                                  fit:
                                                      BoxFit.cover,

                                                  errorBuilder:
                                                      (
                                                    context,
                                                    error,
                                                    stackTrace,
                                                  ) {
                                                    return Container(
                                                      width:
                                                          62,
                                                      height:
                                                          70,
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

                                              const SizedBox(
                                                width:
                                                    12,
                                              ),

                                              Expanded(
                                                child:
                                                    Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,

                                                  children: [
                                                    Text(
                                                      product.brand,
                                                      style:
                                                          const TextStyle(
                                                        color:
                                                            Color(
                                                          0xFF0057A8,
                                                        ),
                                                        fontSize:
                                                            9,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),

                                                    const SizedBox(
                                                      height:
                                                          4,
                                                    ),

                                                    Text(
                                                      product.name,
                                                      maxLines:
                                                          2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          const TextStyle(
                                                        fontSize:
                                                            11,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),

                                                    const SizedBox(
                                                      height:
                                                          5,
                                                    ),

                                                    Text(
                                                      formatPrice(
                                                        product.price,
                                                      ),
                                                      style:
                                                          const TextStyle(
                                                        fontSize:
                                                            10,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              const Icon(
                                                Icons
                                                    .chevron_right,
                                                size:
                                                    18,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                  const SizedBox(
                                    height: 30,
                                  ),
                                ]

                                // ============================================
                                // DEFAULT SEARCH CONTENT
                                // ============================================

                                else ...[
                                  // ================= RECENT SEARCHES =================

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,

                                    children: [
                                      const Text(
                                        'Recent Searches',
                                        style:
                                            TextStyle(
                                          fontSize:
                                              10,
                                          fontWeight:
                                              FontWeight
                                                  .w700,
                                          color:
                                              Color(
                                            0xFF222222,
                                          ),
                                        ),
                                      ),

                                      if (recentSearches
                                          .isNotEmpty)
                                        GestureDetector(
                                          onTap:
                                              () {
                                            setState(
                                              () {
                                                recentSearches
                                                    .clear();
                                              },
                                            );
                                          },

                                          child:
                                              const Text(
                                            'Clear All',
                                            style:
                                                TextStyle(
                                              fontSize:
                                                  8,
                                              fontWeight:
                                                  FontWeight
                                                      .w600,
                                              color:
                                                  Color(
                                                0xFF0057A8,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 7,
                                  ),

                                  if (recentSearches
                                      .isEmpty)
                                    const Padding(
                                      padding:
                                          EdgeInsets
                                              .only(
                                        top:
                                            6,
                                        bottom:
                                            16,
                                      ),

                                      child:
                                          Text(
                                        'No recent searches yet',
                                        style:
                                            TextStyle(
                                          fontSize:
                                              9,
                                          color:
                                              Color(
                                            0xFF888888,
                                          ),
                                        ),
                                      ),
                                    ),

                                  ...recentSearches.map(
                                    (search) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets
                                                .only(
                                          bottom:
                                              17,
                                        ),

                                        child:
                                            Row(
                                          children: [
                                            const SizedBox(
                                              width:
                                                  22,
                                            ),

                                            Expanded(
                                              child:
                                                  GestureDetector(
                                                onTap:
                                                    () {
                                                  searchController.text =
                                                      search;

                                                  searchController.selection =
                                                      TextSelection.fromPosition(
                                                    TextPosition(
                                                      offset:
                                                          search.length,
                                                    ),
                                                  );
                                                },

                                                child:
                                                    Text(
                                                  search,
                                                  style:
                                                      const TextStyle(
                                                    fontSize:
                                                        9,
                                                    fontWeight:
                                                        FontWeight.w500,
                                                    color:
                                                        Color(
                                                      0xFF222222,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            GestureDetector(
                                              onTap:
                                                  () {
                                                setState(
                                                  () {
                                                    recentSearches.remove(
                                                      search,
                                                    );
                                                  },
                                                );
                                              },

                                              child:
                                                  const Text(
                                                '×',
                                                style:
                                                    TextStyle(
                                                  fontSize:
                                                      13,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),

                                  // ================= POPULAR SEARCHES FROM API =================

                                  const Text(
                                    'Popular Searches',
                                    style:
                                        TextStyle(
                                      fontSize:
                                          10,
                                      fontWeight:
                                          FontWeight
                                              .w700,
                                      color:
                                          Color(
                                        0xFF222222,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 9,

                                    children:
                                        popularSearches
                                            .map(
                                      (item) {
                                        return GestureDetector(
                                          onTap:
                                              () {
                                            searchController.text =
                                                item;

                                            searchController.selection =
                                                TextSelection.fromPosition(
                                              TextPosition(
                                                offset:
                                                    item.length,
                                              ),
                                            );

                                            _submitSearch(
                                              item,
                                            );
                                          },

                                          child:
                                              Container(
                                            padding:
                                                const EdgeInsets
                                                    .symmetric(
                                              horizontal:
                                                  16,
                                              vertical:
                                                  7,
                                            ),

                                            decoration:
                                                BoxDecoration(
                                              color:
                                                  const Color(
                                                0xFFC9F36A,
                                              ),

                                              borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                14,
                                              ),
                                            ),

                                            child:
                                                Text(
                                              item,
                                              style:
                                                  const TextStyle(
                                                fontSize:
                                                    9,
                                                fontWeight:
                                                    FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),

                                  const SizedBox(
                                    height: 27,
                                  ),

                                  // ================= BROWSE BY BRAND =================

                                  const Text(
                                    'Browse by Brand',
                                    style:
                                        TextStyle(
                                      fontSize:
                                          10,
                                      fontWeight:
                                          FontWeight
                                              .w700,
                                      color:
                                          Color(
                                        0xFF222222,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),

                                  const Text(
                                    'AGGREGATED BRANDS',
                                    style:
                                        TextStyle(
                                      fontSize:
                                          7,
                                      fontWeight:
                                          FontWeight
                                              .w600,
                                      color:
                                          Color(
                                        0xFF777777,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 7,
                                  ),

                                  // ================= BRANDS FROM API =================

                                  SingleChildScrollView(
                                    scrollDirection:
                                        Axis.horizontal,

                                    child: Row(
                                      children:
                                          brands.map(
                                        (brand) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets
                                                    .only(
                                              right:
                                                  6,
                                            ),

                                            child:
                                                GestureDetector(
                                              onTap:
                                                  () {
                                                _openBrand(
                                                  brand,
                                                );
                                              },

                                              child:
                                                  Container(
                                                height:
                                                    30,

                                                padding:
                                                    const EdgeInsets
                                                        .symmetric(
                                                  horizontal:
                                                      13,
                                                ),

                                                alignment:
                                                    Alignment.center,

                                                decoration:
                                                    BoxDecoration(
                                                  color:
                                                      Colors.white,

                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    16,
                                                  ),

                                                  border:
                                                      Border.all(
                                                    color:
                                                        const Color(
                                                      0xFFE5E5E5,
                                                    ),
                                                  ),
                                                ),

                                                child:
                                                    Text(
                                                  brand,
                                                  style:
                                                      const TextStyle(
                                                    fontSize:
                                                        8,
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    color:
                                                        Color(
                                                      0xFF222222,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 40,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SearchBottomNavigation(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ===================================================================
// SEARCH BOTTOM NAVIGATION
// ===================================================================

class SearchBottomNavigation
    extends StatelessWidget {
  const SearchBottomNavigation({
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
          SearchBottomNavItem(
            icon:
                Icons.home_outlined,

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
          ),

          SearchBottomNavItem(
            icon: Icons.search,
            active: true,
            onTap: () {},
          ),

          SearchBottomNavItem(
            icon:
                Icons.compare_arrows,
            onTap: () {},
          ),

          SearchBottomNavItem(
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

          SearchBottomNavItem(
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

// ===================================================================
// BOTTOM NAV ITEM
// ===================================================================

class SearchBottomNavItem
    extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const SearchBottomNavItem({
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