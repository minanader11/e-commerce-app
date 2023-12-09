import 'package:e_commerce/data/categories.dart';
import 'package:e_commerce/model/category.dart';
import 'package:e_commerce/widgets/drawer.dart';
import 'package:e_commerce/widgets/products_carousel.dart';
import 'package:e_commerce/widgets/vertical_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/widgets/carousel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<category> avaliableCategories = categories;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.background,
        ),
        title: Text(
          'Fashapp',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            color: Theme.of(context).colorScheme.onPrimary,
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageSlider(),
            Divider(),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primary,
                ),
                height: 40,
                width: 120,
                child: Text(
                  'Categories',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.background,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 210,
              child: VerticalList(
                categoriesItem: avaliableCategories,
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primary,
                ),
                height: 40,
                width: 200,
                child: Text(
                  'Products Images',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.background,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            ProductsCarosuel(),
          ],
        ),
      ),
    );
  }
}
