// models/product_model.dart
class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  bool isFavourite;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    this.isFavourite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
      imageUrl: 'http://10.74.220.100:4040${json['imageUrl']}',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

   @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price, description: $description, imageUrl: $imageUrl}';
  }
  
}
