import 'package:e_commerce/providers/email_provider.dart';
import 'package:e_commerce/providers/favorites_provider.dart';
import 'package:e_commerce/providers/orders_providers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  ProductDetailsScreen({super.key, required this.product});
  final Map<String, dynamic> product;
  @override
  ConsumerState<ProductDetailsScreen> createState() {
    return _ProductDetailsScreenState();
  }
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  @override
  void setState(VoidCallback fn) {
    ref
        .watch(FavoritesProvider.notifier)
        .fetchDataFromFirestore(ref.read(emailProvider));
    super.setState(fn);
  }

  void onSelectAddOrder() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Adding to orders',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              ref.read(OrdersProvider.notifier).addToOrders(widget.product);
              Navigator.of(context).pop();
              //Navigator.of(context).push(MaterialPageRoute(
              // builder: (context) => MainScreen(),
              //));

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Added to my orders',
                  ),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
            label: Text(
              'Confirm',
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.cancel,
                color: Theme.of(context).colorScheme.primary),
            label: Text(
              'Cancel',
            ),
          ),
        ],
      ),
    );
  }

  void onRemoveOrder() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Removing order',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              ref.read(OrdersProvider.notifier).cancelOrder(widget.product);
              ref.read(OrdersProvider).remove(widget.product);
              Navigator.of(context).pop();
              //Navigator.of(context).push(MaterialPageRoute(
              // builder: (context) => MainScreen(),
              //));

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Remove order',
                  ),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
            label: Text(
              'Confirm',
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.cancel,
                color: Theme.of(context).colorScheme.primary),
            label: Text(
              'Cancel',
            ),
          ),
        ],
      ),
    );
  }

  void onTapFavorite() {
    if (ref.read(FavoritesProvider).contains(widget.product)) {
      ref.watch(FavoritesProvider.notifier).removeFromFavorites(widget.product);
      setState(() {
        ref.watch(FavoritesProvider).remove(widget.product);
      });

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'removed from favorites',
          ),
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      setState(() {
        ref.watch(FavoritesProvider.notifier).addToFavorites(widget.product);
      });

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Added to favorites',
          ),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: onTapFavorite,
              icon: Icon(ref.read(FavoritesProvider).contains(widget.product)
                  ? Icons.star
                  : Icons.star_border))
        ],
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.background,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.product['title'],
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Theme.of(context).colorScheme.background),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.product['image'],
              height: 200,
              width: double.infinity,
            ),
            SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              child: Text(
                'Description',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ),
            Divider(
              indent: 0,
              endIndent: 230,
              thickness: 3,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.product['description'],
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Price:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  '\$${widget.product['price']}',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ],
            ),
            Divider(
              indent: 0,
              endIndent: 325,
              thickness: 3,
              color: Theme.of(context).colorScheme.primary,
            ),
            Spacer(),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextButton.icon(
                style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary),
                onPressed: () {
                  if (!ref.watch(OrdersProvider).contains(widget.product)) {
                    onSelectAddOrder();
                  } else {
                    onRemoveOrder();
                  }
                  ;
                },
                icon: Icon(
                  ref.read(OrdersProvider).contains(widget.product)
                      ? Icons.remove_circle
                      : Icons.add,
                  color: Theme.of(context).colorScheme.background,
                  size: 40,
                ),
                label: Text(
                  ref.read(OrdersProvider).contains(widget.product)
                      ? 'Remove Order'
                      : 'Add to Orders',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                      fontSize: 20),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
