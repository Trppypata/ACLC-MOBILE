// controllers/product_controller.dart
import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductController {
  List<Product> products = [];

  Future<void> fetchProducts() async {
    final response = await http.get(Uri.parse('http://10.74.220.100:4040/api/products'));
    if (response.statusCode == 200) {
      final List<dynamic> productJson = json.decode(response.body);
      products = productJson.map((json) => Product.fromJson(json)).toList();
      print('Products fetched: $products'); // Log the fetched products
    } else {
      print('Failed to load products: ${response.reasonPhrase}');
      throw Exception('Failed to load products');
    }
    
  }
  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.74.220.100:4040/products'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );
      if (response.statusCode == 201) {
        products.add(Product.fromJson(json.decode(response.body)));
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> editProduct(Product product) async {
    try {
      final response = await http.put(
        Uri.parse('http://10.74.220.100:4040/products/${product.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(product.toJson()),
      );
      if (response.statusCode == 200) {
        int index = products.indexWhere((p) => p.id == product.id);
        if (index != -1) {
          products[index] = product;
        }
      }
    } catch (e) {
      // Handle error
    }
  }

 Future<void> deleteProduct(int productId) async {
    try {
      final url = Uri.parse('http://10.74.220.100:4040/api/products/$productId');
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        products.removeWhere((product) => product.id == productId);
        debugPrint('Product deleted: $productId');
      } else {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      debugPrint('An error occurred while deleting the product: $e');
      rethrow;
    }
  }
}
