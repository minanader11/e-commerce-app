import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/providers/email_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
/*class Product {
  final String id;
  final String title;
  final double price;
  final String description;
  final String image;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.rating,
  });
}*/

class FavoritesNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  final String email;
  FavoritesNotifier(this.email) : super([]);
  void addToFavorites(Map<String, dynamic> product) async {
    state = [...state, product];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection('favproducts')
        .add({
      "id": product['id'],
      "title": product['title'],
      "price": product['price'],
      "description": product['description'],
      "image": product['image'],
      "rating": product['rating']
    });
  }

  void removeFromFavorites(Map<String, dynamic> product) async {
    state = [...state];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection('favproducts')
        .where('title', isEqualTo: product['title'])
        .get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  void updateProducts(List<Map<String, dynamic>> newProducts) {
    state = newProducts;
  }

  Future<void> fetchDataFromFirestore(String email) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .collection('favproducts')
          .get();

      final products = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': data['id'],
          'title': data['title'],
          'price': data['price'],
          'description': data['description'],
          'image': data['image'],
          'rating': data['rating'],
        };
      }).toList();

      updateProducts(products);
    } catch (e) {
      print('Error fetching data from Firestore: $e');
    }
  }
}

final FavoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Map<String, dynamic>>>((ref) {
  final email = ref.watch(emailProvider);
  return FavoritesNotifier(email);
});
