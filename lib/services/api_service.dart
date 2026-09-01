import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../models/home_item.dart';

class ApiService {
  static const String baseUrl =
      'https://6a920c977751d35ce47ed5b4.mockapi.io';

  // =====================================================
  // GET ALL PRODUCTS
  // =====================================================

  static Future<List<Product>> getProducts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/products'),
    );

    if (response.statusCode == 200) {
      final dynamic decoded =
          jsonDecode(response.body);

      if (decoded is! List) {
        throw Exception(
          'Products response is not a list',
        );
      }

      return decoded
          .map<Product>(
            (item) => Product.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();
    }

    throw Exception(
      'Failed to load products. '
      'Status code: ${response.statusCode}',
    );
  }

  // =====================================================
  // NORMALIZE BRAND
  // =====================================================

  static String _normalizeBrand(
    String value,
  ) {
    return value
        .toLowerCase()
        .replaceAll(
          RegExp(r'[^a-z0-9]'),
          '',
        );
  }

  // =====================================================
  // GET PRODUCTS BY BRAND
  // =====================================================

  static Future<List<Product>>
      getProductsByBrand(
    String brand,
  ) async {
    final List<Product> products =
        await getProducts();

    final String wantedBrand =
        _normalizeBrand(brand);

    return products.where((product) {
      return _normalizeBrand(product.brand) ==
          wantedBrand;
    }).toList();
  }

  // =====================================================
  // GET PRODUCT BY ID
  // =====================================================

  static Future<Product> getProductById(
    String id,
  ) async {
    final response = await http.get(
      Uri.parse('$baseUrl/products/$id'),
    );

    if (response.statusCode == 200) {
      return Product.fromJson(
        Map<String, dynamic>.from(
          jsonDecode(response.body),
        ),
      );
    }

    throw Exception(
      'Failed to load product. '
      'Status code: ${response.statusCode}',
    );
  }

  // =====================================================
  // GET HOME DATA
  // =====================================================

  static Future<List<HomeItem>>
      getHomeItems() async {
    final response = await http.get(
      Uri.parse('$baseUrl/home'),
    );

    if (response.statusCode == 200) {
      final dynamic decoded =
          jsonDecode(response.body);

      if (decoded is! List) {
        throw Exception(
          'Home response is not a list',
        );
      }

      return decoded
          .map<HomeItem>(
            (item) => HomeItem.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList();
    }

    throw Exception(
      'Failed to load home data. '
      'Status code: ${response.statusCode}',
    );
  }
}