import 'package:flutter/material.dart';
import 'package:phase_2_implementation/my_cart/my_cart.dart';
import 'package:phase_2_implementation/payment/payment.dart';
import 'package:url_launcher/url_launcher.dart';

class Donate extends StatelessWidget {
  const Donate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate Page'),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/Welcome Page.png'), // Your image path here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.only(top: 50),
              child: const Text(
                'Donate',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.only(top: 260),
              child: const Text(
                'Please select the donation type',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.fastfood,
                      color: Colors.deepPurple, size: 50),
                  label: const Text('Food'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ShoppingCartPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 50),
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    elevation: 4,
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.attach_money,
                      color: Colors.deepPurple, size: 50),
                  label: const Text('Money'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentMethodPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 50),
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    elevation: 4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
