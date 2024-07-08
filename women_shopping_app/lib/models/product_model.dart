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
    const String baseUrl = 'https://api.timbu.cloud/images/';

    double? extractPrice(Map<String, dynamic> json) {
      if (json['current_price'] != null && json['current_price'].isNotEmpty) {
        var prices = json['current_price'][0];
        if (prices is Map) {
          return prices.values.first[0];
        }
      }
      return null;
    }

    // Extract the first image URL from photos list if available
    String? extractImageUrl(Map<String, dynamic> json) {
      if (json['photos'] != null && json['photos'].isNotEmpty) {
        return baseUrl + json['photos'][0]['url'];
      }
      return null;
    }

    return Product(
      name: json['name'],
      // description: json['description'],
      imageUrl: extractImageUrl(json),
      price: extractPrice(json),
    );
  }
}
