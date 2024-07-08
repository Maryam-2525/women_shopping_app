class Product {
  final String name;
  // final String description;
  final String? imageUrl;
  final double? price;

  Product({
    required this.name,
    // required this.description,
    this.imageUrl,
    this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    double? extractPrice(Map<String, dynamic> json) {
      if (json['current_price'] != null && json['current_price'].isNotEmpty) {
        var prices = json['current_price'][0];
        if (prices is Map) {
          return prices.values.first[0];
        }
      }
      return null;
    }

    return Product(
      name: json['name'],
      // description: json['description'],
      imageUrl: json['product_image'].isNotEmpty
          ? json['product_image'][0]['url']
          : null,
      price: extractPrice(json),
    );
  }
}
