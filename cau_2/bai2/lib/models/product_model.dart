class Product {
  final String title;
  final double price;
  final String description;

  Product({
    required this.title,
    required this.price,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'] ?? 'Không có tiêu đề',
      price: (json['price'] is String)
          ? double.parse(json['price'])
          : (json['price'] as num).toDouble(),
      description: json['description'] ?? 'Không có mô tả',
    );
  }
}