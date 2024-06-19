import 'package:flutter/material.dart';
import 'package:ecommerce/controllers/product_controller.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/views/add_product_screen.dart';
import 'package:ecommerce/views/edit_product_screen.dart';
import 'package:ecommerce/views/product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  final ProductController controller;

  const ProductListScreen({required this.controller});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    widget.controller.fetchProducts().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProductScreen(controller: widget.controller),
                ),
              ).then((_) {
                widget.controller.fetchProducts().then((_) {
                  setState(() {});
                });
              });
            },
          ),
        ],
      ),
      body: widget.controller.products.isEmpty
          ? Center(child: Text('No products found'))
          : ListView.builder(
              itemCount: widget.controller.products.length,
              itemBuilder: (context, index) {
                final product = widget.controller.products[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          child: product.imageUrl.isNotEmpty
                              ? Image.network(product.imageUrl, fit: BoxFit.cover)
                              : Icon(Icons.image),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'WW-DR-GR-XS-001', 
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                product.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Grey | 2 items | Medium', // Example details, replace with product-specific details
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, size: 18),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditProductScreen(product: product, controller: widget.controller),
                                      ),
                                    ).then((_) {
                                      widget.controller.fetchProducts().then((_) {
                                        setState(() {});
                                      });
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, size: 18),
                                  onPressed: () {
                                    widget.controller.deleteProduct(product.id).then((_) {
                                      widget.controller.fetchProducts().then((_) {
                                        setState(() {});
                                      });
                                    });
                                  },
                                ),
                              ],
                            ),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}', 
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 20, 140, 22),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
