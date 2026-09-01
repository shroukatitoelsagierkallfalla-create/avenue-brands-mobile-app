class Product {
  final String id;
  final String name;
  final String image;
  final String brand;
  final double price;
  final String description;
  final String category;
  final String gender;
  final double rating;
  final int reviews;
  final String color;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.brand,
    required this.price,
    required this.description,
    required this.category,
    required this.gender,
    required this.rating,
    required this.reviews,
    required this.color,
  });

  factory Product.fromJson(
    Map<String, dynamic> json,
  ) {
    return Product(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      brand: json['brand']?.toString() ?? '',
      price: double.tryParse(
            json['price']?.toString() ?? '0',
          ) ??
          0,
      description:
          json['description']?.toString() ?? '',
      category:
          json['category']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      rating: double.tryParse(
            json['rating']?.toString() ?? '0',
          ) ??
          0,
      reviews: int.tryParse(
            json['reviews']?.toString() ?? '0',
          ) ??
          0,
      color: json['color']?.toString() ?? '',
    );
  }
}