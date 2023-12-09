import 'package:e_commerce/screens/product%20_details.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key, required this.products});
  final List<Map<String, dynamic>> products;
  String firstLetterCapital(List<Map<String, dynamic>> products) {
    return products[0]['category'][0].toString().toUpperCase() +
        products[0]['category'].toString().substring(1);
  }

  void onSelectProduct(
      Map<String, dynamic> product, int index, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductDetailsScreen(product: product),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.background,
        ),
        title: Text(
          firstLetterCapital(products),
          style: TextStyle(color: Theme.of(context).colorScheme.background),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                onSelectProduct(products[index], index, context);
              },
              child: Stack(
                children: [
                  // Background Image
                  Image.network(
                    products[index]['image'],
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 300,
                  ),
                  // Overlaying Text
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black,
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                      child: Text(
                        products[index]['title'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
