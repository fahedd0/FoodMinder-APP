import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phase_2_implementation/firebase/firebase_manager.dart';
import 'package:phase_2_implementation/models/cart_item.dart';
import 'package:phase_2_implementation/donate_food/donate_food_page.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({
    super.key,
  });

  @override
  ShoppingCartPageState createState() => ShoppingCartPageState();
}

class ShoppingCartPageState extends State<ShoppingCartPage> {
  List<CartItem> cartItems = [];
  
  @override
  void initState() {
    super.initState();

    FirebaseManager.getUserCartItems().then(
      (value) => setState(() {
        cartItems = value;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  // Navigate to DonateScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DonateFoodPage(
                        itemsInCart: [],
                      ),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.purple),
                  ),
                ),
                child: const Text(
                  'Donate',
                  style: TextStyle(color: Colors.purple, fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: cartItems.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          var item = cartItems[index];
          return CartItemWidget(
            item,
            onQuantityChange: () {
              setState(() {});
            },
          );
        },
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final Function() onQuantityChange;
  const CartItemWidget(this.item, {super.key, required this.onQuantityChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.purple, width: 3),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Image.network(item.category.categoryImage, width: 100, height: 100),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(item.weight.toString()),
                Text(DateFormat(DateFormat.YEAR_MONTH_DAY)
                    .format(item.expiryDate)),
              ],
            ),
            const Spacer(),
            Counter(
              quantity: item.quantity.toInt(),
              onQuantityChange: (int newQuantity) {
                item.quantity = newQuantity.toDouble();
                onQuantityChange();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Counter extends StatelessWidget {
  final int quantity;
  final Function(int newQuantity) onQuantityChange;

  const Counter({
    super.key,
    required this.quantity,
    required this.onQuantityChange,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => onQuantityChange(quantity - 1),
        ),
        Text(quantity.toString()),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => onQuantityChange(quantity + 1),
        ),
      ],
    );
  }
}
