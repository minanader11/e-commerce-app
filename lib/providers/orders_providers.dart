import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/providers/email_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  final String email;
  OrdersNotifier(this.email) : super([]);
  void addToOrders(Map<String, dynamic> product) async {
    state = [...state, product];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection('orderedProducts')
        .add({
      "id": product['id'],
      "title": product['title'],
      "price": product['price'],
      "description": product['description'],
      "image": product['image'],
      "rating": product['rating']
    });
  }

  void cancelOrder(Map<String, dynamic> product) async {
    state = [...state];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .collection('orderedProducts')
        .where('title', isEqualTo: product['title'])
        .get();
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }
}

final OrdersProvider =
    StateNotifierProvider<OrdersNotifier, List<Map<String, dynamic>>>((ref) {
  final email = ref.watch(emailProvider);
  return OrdersNotifier(email);
});
