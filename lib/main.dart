import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop',
      home: ShoppingList(product: <Products>[
        Products(name: 'Eggs'),
        Products(name: 'flower'),
        Products(name: 'snack'),
        Products(name: 'milk'),
        Products(name: 'oil'),
        Products(name: 'bread'),
        Products(name: 'rice'),
      ]),
    );
  }
}

class Products {
  Products({required this.name});

  final String name;
}
typedef CartChangeCallBack = void Function(Products products, bool inCart);

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key, required this.product}) : super(key: key);

  final List<Products> product;

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Products> shoppingCart = <Products>{};

  void handleCartChange(Products products, bool inCart) {
    setState(() {
      if (inCart) {
        shoppingCart.remove(products);
      } else {
        shoppingCart.add(products);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('shopping app'),
      ),
      body: ListView(
          children: widget.product
              .map((Products products) => ShoppingListItem(
                  products: products,
                  inCart: shoppingCart.contains(products),
                  onCartChange: handleCartChange))
              .toList()),
    );
  }
}

class ShoppingListItem extends StatelessWidget {
  const ShoppingListItem(
      {required this.products,
      required this.inCart,
      required this.onCartChange});

  final Products products;
  final bool inCart;
  final CartChangeCallBack onCartChange;

  TextStyle getTextStyle(BuildContext context) {
    if (inCart) {
      return const TextStyle(
          color: Colors.yellow, decoration: TextDecoration.lineThrough);
    } else {
      return TextStyle(color: Theme.of(context).primaryColor);
    }
  }

  Color getColor(BuildContext context) {
    return inCart ? Colors.yellow : Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      onTap: () {
        onCartChange(products, inCart);
      },
      title: Text(products.name, style: getTextStyle(context)),
      leading: CircleAvatar(
        child: Text(products.name[0]),
        radius: 22,
        backgroundColor: getColor(context),
      ),
    );
  }
}
