import 'dart:convert';

import 'package:phase_2_implementation/models/food_category.dart';

class CartItem {
  FoodCategory category;
  String name;
  String barcode;
  double quantity;
  double weight;
  DateTime expiryDate;

  CartItem({
    required this.category,
    required this.name,
    required this.barcode,
    required this.quantity,
    required this.weight,
    required this.expiryDate,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'category': category.toMap()});
    result.addAll({'name': name});
    result.addAll({'barcode': barcode});
    result.addAll({'quantity': quantity});
    result.addAll({'weight': weight});
    result.addAll({'expiryDate': expiryDate.millisecondsSinceEpoch});

    return result;
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      category: FoodCategory.fromMap(map['category']),
      name: map['name'] ?? '',
      barcode: map['barcode'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      weight: map['weight']?.toDouble() ?? 0.0,
      expiryDate: DateTime.fromMillisecondsSinceEpoch(map['expiryDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) => CartItem.fromMap(json.decode(source));
}
