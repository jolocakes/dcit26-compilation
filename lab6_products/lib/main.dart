import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// 1. Immutable Product model
class Product {
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.rating,
    required this.price,
  });

  final String id;
  final String title;
  final String description;
  final double rating;
  final double price;
}


const List<Product> products = [
  Product(
    id: 'P-001',
    title: 'Wireless Mouse',
    description: 'Comfortable wireless mouse for daily work.',
    rating: 4.5,
    price: 599,
  ),
  Product(
    id: 'P-002',
    title: 'Notebook Set',
    description: 'Pack of 5 ruled notebooks for class notes.',
    rating: 4.2,
    price: 120,
  ),
  Product(
    id: 'P-003',
    title: 'Desk Lamp',
    description: 'Adjustable LED lamp with warm and cool light modes.',
    rating: 4.7,
    price: 850,
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 6 - Product Data',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF237345)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: const Color(0xFF237345),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.shopping_bag)),
              title: Text(product.title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Rating ${product.rating}\n₱${product.price.toStringAsFixed(0)}'),
              isThreeLine: true,
              // 4. Tappable: pass the selected Product via constructor
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(product: product),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}


class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: const Color(0xFF237345),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(radius: 48, child: Icon(Icons.shopping_bag, size: 40)),
            ),
            const SizedBox(height: 24),
            Text(product.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(product.description),
            const SizedBox(height: 16),
            Text('Rating: ${product.rating} / 5',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Product key: ${product.id}'),
          ],
        ),
      ),
    );
  }
}