// product_list_screen.dart

import 'package:flutter/material.dart';
import 'package:women_shopping_app/screens/checkout.dart';
import '../services/api_service.dart';
import '../models/product_model.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = fetchProducts().then((data) {
      return (data['items'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList();
    });
  }

  void onPressed() {
    setState(() {
      const CheckoutScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final product = snapshot.data![index];
              return Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                      leading: product.imageUrl != null
                          ? Image.network(product.imageUrl!,
                              width: 50, height: 50)
                          : Container(
                              width: 50, height: 50, color: Colors.grey),
                      title: Text(product.name),
                      subtitle: product.price != null
                          ? Text('\$${product.price}')
                          : null,
                      // const Text('this is description'),
                      trailing: TextButton.icon(
                          onPressed: onPressed,
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary),
                          icon:
                              const Icon(Icons.shopping_cart_checkout_rounded),
                          label: const Text('Add To Cart'))),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
