import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductScreen(),
    );
  }
}

class Product {
  final String name;
  final int calories;

  Product(this.name, this.calories);
}

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Product _selectedProduct = Product('Имя продукта', 0);

  void _navigateToProductDetails() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductDetailsScreen()),
    );

    if (result != null) {
      setState(() {
        _selectedProduct = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Продукт: ${_selectedProduct?.name ?? ''}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _selectedProduct != null
                ? Text('Название продукта: ${_selectedProduct.name}\nКалорийность: ${_selectedProduct.calories}')
                : Text('Нажмите, чтобы добавить продукт'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToProductDetails,
        tooltip: 'Добавить продукт',
        child: Icon(Icons.add),
      ),
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Детали продукта'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, Product('Яблоко', 52));
              },
              child: Text('Добавить Яблоко'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, Product('Молоко', 42));
              },
              child: Text('Добавить Молоко'),
            ),
          ],
        ),
      ),
    );
  }
}