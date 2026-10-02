import 'package:flutter/material.dart';

void main() => runApp(const MyApp());


class Product {
  final String name;
  final String description;
  final int price;
  final String label;
  final Color color;
  final bool starred;

  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.label,
    required this.color,
    this.starred = false,
  });

  static const List<Product> items = [
    Product(
      name: 'Pixel',
      description: 'Pixel is the most featureful phone ever',
      price: 800,
      label: 'pixel 1',
      color: Color(0xFF4466D6),
    ),
    Product(
      name: 'Laptop',
      description: 'Laptop is most productive development tool',
      price: 2000,
      label: 'laptop',
      color: Color(0xFF6CD24F),
    ),
    Product(
      name: 'Tablet',
      description: 'Tablet is the most useful device ever for meeting',
      price: 1500,
      label: 'tablet',
      color: Color(0xFFCFC452),
      starred: true,
    ),
    Product(
      name: 'Pendrive',
      description: 'iPhone is the stylist phone ever',
      price: 100,
      label: 'pen drive',
      color: Color(0xFFB8634A),
    ),
    Product(
      name: 'Floppy Drive',
      description: 'iPhone is the stylist phone ever',
      price: 20,
      label: 'floppy',
      color: Color(0xFF66B8AA),
    ),
    Product(
      name: 'Monitor',
      description: 'A big screen for a better workspace',
      price: 300,
      label: 'monitor',
      color: Color(0xFF8E6BBF),
    ),
  ];
}

// app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4A93E8),
          foregroundColor: Colors.white,
        ),
      ),
      home: const ProductListPage(),
    );
  }
}

// the product list page on home screen
class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final products = Product.items;

    return Scaffold(
      appBar: AppBar(title: const Text('Product Navigation')),
      body: ListView.builder(
        padding: const EdgeInsets.all(2),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
             // navigate the details page when tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: product),
                ),
              );
            },
            child: ProductBox(product: product),
          );
        },
      ),
    );
  }
}

/// reusable pieces
class ProductImage extends StatelessWidget {
  final Product product;
  final double height;
  final double? width;
  final double fontSize;

  const ProductImage({
    super.key,
    required this.product,
    required this.height,
    this.width,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: product.color,
      alignment: Alignment.center,
      child: Text(
        product.label,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

class StarRow extends StatelessWidget {
  final bool filled;
  final MainAxisAlignment alignment;

  const StarRow({
    super.key,
    required this.filled,
    this.alignment = MainAxisAlignment.spaceAround,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: List.generate(
        3,
            (_) => Icon(
          filled ? Icons.star : Icons.star_border,
          color: Colors.red,
          size: 20,
        ),
      ),
    );
  }
}


class ProductBox extends StatelessWidget {
  final Product product;

  const ProductBox({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(3),
      child: SizedBox(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProductImage(
              product: product,
              height: 120,
              width: 140,
              fontSize: 28,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Price: ${product.price}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    StarRow(filled: product.starred),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// details page
class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar automatically shows a back arrow when pushed via Navigator.
      appBar: AppBar(title: Text(product.name)),
      body: Column(
        children: [
          ProductImage(
            product: product,
            height: 300,
            width: double.infinity,
            fontSize: 80,
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFFAFAFA),
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(product.description),
                  Text('Price: ${product.price}'),
                  StarRow(
                    filled: product.starred,
                    alignment: MainAxisAlignment.end,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}