import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phase_2_implementation/models/cart_item.dart';
import 'package:phase_2_implementation/models/food_category.dart';
// import 'package:firebase_core/firebase_core.dart';

class FirebaseManager {
  static const String _cartCollectionName = "user_cart";
  static const String _catagoriesCollectionName = "food_categories";
  static const String _userIdField = "user_id";
  static const String _cartItemsCollectionName = "cart_items";

  static Future<List<FoodCategory>> getFoodCategories() async {
    List<FoodCategory> items = [];
    try {
      var result = await FirebaseFirestore.instance.collection(_catagoriesCollectionName).get();
      items = result.docs.map((e) {
        var data = e.data();
        return FoodCategory(
          categoryId: e.id,
          categoryName: data["name"],
          categoryImage: data["image_url"],
        );
      }).toList();
    } catch (e, s) {
      print(e);
      print(s);
    }
    return items;
  }

  static Future addItemToCart(CartItem cartItem) async {
    try {
      var currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId == null) return false;

      var result = await FirebaseFirestore.instance
          .collection(_cartCollectionName)
          .doc(currentUserId)
          .collection(_cartItemsCollectionName)
          .add(cartItem.toMap());
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  static Future<List<CartItem>> getUserCartItems() async {
    List<CartItem> items = [];
    try {
      var currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId == null) return items;

      var result = await FirebaseFirestore.instance
          .collection(_cartCollectionName)
          .doc(currentUserId)
          .collection(_cartItemsCollectionName)
          .get();

      items = result.docs.map((e) {
        var data = e.data();
        return CartItem.fromMap(data);
      }).toList();
    } catch (e, s) {
      print(e);
      print(s);
    }

    return items;
  }
}
