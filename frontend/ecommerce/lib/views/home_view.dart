// views/home_view.dart
import 'package:flutter/material.dart';
import 'package:ecommerce/controllers/home_controller.dart';
import 'package:ecommerce/controllers/product_controller.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/views/product_list_screen.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController controller = HomeController();
  final ProductController productController = ProductController();

  @override
  void initState() {
    super.initState();
    controller.fetchProducts().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductListScreen(controller: productController),
                ),
              ).then((_) {
                setState(() {});
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.green,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              _buildFeaturedSection(),
              _buildTrendingSection(),
              _buildForYouSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 32,
        width: 250,
        child: TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 8),
            prefixIcon: const Icon(Icons.search),
            hintText: 'Search...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'All Featured',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.featuredProducts.length,
            itemBuilder: (context, index) {
              final product = controller.featuredProducts[index];
              return Column(
                children: [
                  Image.network(product.imageUrl, width: 80, height: 80),
                  Text(product.name),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrendingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        color: Colors.grey[300],
        height: 150,
        child: const Center(
          child: Text('50-40% OFF\nNow in (product)', textAlign: TextAlign.center),
        ),
      ),
    );
  }

  Widget _buildForYouSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'For You',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: controller.forYouProducts.length,
          itemBuilder: (context, index) {
            final product = controller.forYouProducts[index];
            return Card(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.network(product.imageUrl, width: double.infinity, height: 100, fit: BoxFit.cover),
                      Positioned(
                        top: 1,
                        right: 1,
                        child: IconButton(
                          icon: Icon(
                            product.isFavourite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              controller.toggleFavourite(product);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name),
                        Text('${product.price} PHP'),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
