import 'dart:convert';

class FoodCategory {
  String categoryId;
  String categoryName;
  String categoryImage;
  FoodCategory({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'categoryId': categoryId});
    result.addAll({'categoryName': categoryName});
    result.addAll({'categoryImage': categoryImage});

    return result;
  }

  factory FoodCategory.fromMap(Map<String, dynamic> map) {
    return FoodCategory(
      categoryId: map['categoryId'] ?? '',
      categoryName: map['categoryName'] ?? '',
      categoryImage: map['categoryImage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodCategory.fromJson(String source) => FoodCategory.fromMap(json.decode(source));
}
