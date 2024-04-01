import 'package:get/get.dart';

class CartController extends GetxController {
 List<Cart> myCart = [];

}

class Cart {
  String title;
  String image;
  String category;
  String expiryDate;
  dynamic quantity;
  bool isQuantity;

  Cart(
      {required this.title,
      required this.image,
      required this.isQuantity,
      required this.category,
      required this.expiryDate,
      this.quantity});
}
