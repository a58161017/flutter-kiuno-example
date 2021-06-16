import 'package:flutter/material.dart';

class ListRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
      title: 'Startup List',
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, "$args return");
            },
          ),
          title: Text('Kiuno\'s list'),
        ),
        body: ShoppingList(
          products: <Product>[
            Product(name: 'Eggs'),
            Product(name: 'Flour'),
            Product(name: 'Chocolate chips'),
          ],
        ),
      ),
    );
  }
}

class Product {
  Product({this.name});
  final String name;
  bool inCart = false;
}

typedef CartChangedCallback(Product product, bool inCart);

class ShoppingList extends StatefulWidget {
  ShoppingList({key, this.products}) : super(key: key);

  final List<Product> products;

  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<ShoppingList> {
  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      product.inCart = !inCart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      children: widget.products.map((Product product) {
        return _ShoppingItem(
          product: product,
          inCart: product.inCart,
          onCartChanged: _handleCartChanged,
        );
      }).toList(),
    );
  }
}

class _ShoppingItem extends StatelessWidget {
  _ShoppingItem({this.product, this.inCart, this.onCartChanged})
      : super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    return inCart
        ? TextStyle(
            color: Colors.black54,
            decoration: TextDecoration.lineThrough,
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart);
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text('${product.name[0]}'),
      ),
      title: Text(
        product.name,
        style: _getTextStyle(context),
      ),
    );
  }
}