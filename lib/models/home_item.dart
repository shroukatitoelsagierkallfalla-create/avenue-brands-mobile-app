class HomeItem {
  final String id;
  final String type;
  final String image;
  final String title;
  final String subtitle;
  final String extraText;
  final String actionText;
  final String productId;
  final int order;

  HomeItem({
    required this.id,
    required this.type,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.extraText,
    required this.actionText,
    required this.productId,
    required this.order,
  });

  factory HomeItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return HomeItem(
      id: json['id']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      subtitle: json['subtitle']?.toString() ?? '',
      extraText:
          json['extraText']?.toString() ?? '',
      actionText:
          json['actionText']?.toString() ?? '',
      productId:
          json['productId']?.toString() ?? '',
      order: int.tryParse(
            json['order']?.toString() ?? '0',
          ) ??
          0,
    );
  }
}