// controllers/home_controller.dart
import 'package:ecommerce/controllers/product_controller.dart';
import 'package:ecommerce/models/product_model.dart';

class HomeController {
  final ProductController productController = ProductController();
  List<Product> featuredProducts = [];
  List<Product> forYouProducts = [];

  HomeController() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    await productController.fetchProducts();
    featuredProducts = productController.products; // Replace with actual logic
    forYouProducts = productController.products;  // Replace with actual logic
  }

  void toggleFavourite(Product product) {
    product.isFavourite = !product.isFavourite;
  }
}
