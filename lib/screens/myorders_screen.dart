import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/providers/email_provider.dart';
import 'package:e_commerce/providers/orders_providers.dart';
import 'package:e_commerce/screens/product%20_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyOrdersScreen extends ConsumerWidget {
  MyOrdersScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(OrdersProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Orders',
            style: TextStyle(
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.background,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(ref.watch(emailProvider))
              .collection('orderedProducts')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error : ${snapshot.error}',
                ),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text('Document does not exist'),
              );
            }
            List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
            final products = documents
                .map((doc) => doc.data() as Map<String, dynamic>)
                .toList();

            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsScreen(product: products[index]),
                      ));
                    },
                    child: Stack(
                      children: [
                        // Background Image
                        Image.network(
                          documents[index]['image'],
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
                            color: Colors.black54,
                            padding: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 44),
                            child: Text(
                              documents[index]['title'],
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
            );
          },
        ));
  }
}
