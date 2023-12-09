import 'package:e_commerce/data/fakedata.dart';
import 'package:e_commerce/model/category.dart';
import 'package:e_commerce/screens/products_screen.dart';

import 'package:flutter/material.dart';

class VerticalList extends StatelessWidget {
  const VerticalList({super.key, required this.categoriesItem});
  final List<category> categoriesItem;
  String firstLetterCapital(List<category> categoriesItem, int index) {
    return categoriesItem[index].title[0].toUpperCase() +
        categoriesItem[index].title.substring(1);
  }

  void onSelectCategories(BuildContext context, category category) {
    final filteredProducts = products
        .where((product) => product['category'] == category.title)
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductScreen(products: filteredProducts),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesItem.length,
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {
              onSelectCategories(context, categoriesItem[index]);
            },
            child: /*ListTile(
              title: Text(
                firstLetterCapital(
                  categoriesItem,
                  index,
                ),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary, fontSize: 18),
              ),
              trailing: Image.asset(
                categoriesItem[index].imageName,
                height: 40,
                width: 50,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),*/
                SizedBox(
              width: 160,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      categoriesItem[index].imageName,
                      height: 120.0,
                      width: 120.0,
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        firstLetterCapital(
                          categoriesItem,
                          index,
                        ),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
