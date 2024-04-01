//donate food page
import 'package:flutter/material.dart';
//import 'package:dotted_line/dotted_line.dart';
import 'package:phase_2_implementation/pickup_adress_page/pickup_adress_page.dart';
import 'package:url_launcher/url_launcher.dart';

class DonateFoodPage extends StatefulWidget {
  final List<Map<String, dynamic>> itemsInCart;

  const DonateFoodPage({super.key, required this.itemsInCart});

  @override
  _DonateFoodPageState createState() => _DonateFoodPageState();
}

class _DonateFoodPageState extends State<DonateFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donate Food')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              height: 300,
              color:
                  const Color.fromARGB(255, 233, 208, 245), // Light pink color
              child: ListView.separated(
                itemCount: widget.itemsInCart.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = widget.itemsInCart[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                item['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Checkbox(
                              value: item['isSelected'] ?? false,
                              onChanged: (bool? value) {
                                setState(() {
                                  item['isSelected'] = value ?? false;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Weight: ${item['weight']}'),
                            const Spacer(),
                            Text('Quantity: ${item['quantity']}'),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Expiry Date: ${item['expiryDate']}'),
                          ],
                        ),
                        //const DottedLine(),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 8),
              ),
            ),
          ),
          button('Deliver to FoodBank', Colors.deepPurple, Colors.white,
              _deliverToFoodBank),
          const SizedBox(height: 20),
          button('Request Pick up', const Color.fromARGB(255, 237, 234, 160),
              Colors.black, _requestPickUp),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget button(
      String text, Color bgColor, Color textColor, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          minimumSize: const Size(120, 40),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }

  void _deliverToFoodBank() async {
    const url = 'https://www.google.com/maps/search/?api=1&query=food+bank';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the situation when the URL can't be launched
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch URL')),
      );
    }
  }

  void _requestPickUp() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PickupAddressPage(), // Replace with actual page
    ));
  }
}
