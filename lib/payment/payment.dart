import 'package:flutter/material.dart';
import 'package:phase_2_implementation/home_screen/home_screen.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({Key? key}) : super(key: key);

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  // Define the list of fixed donation amounts
  final List<int> donationAmounts = [5, 10, 20, 100];

  // Define the selected donation amount
  int? selectedAmount;

  // Define the controller for the custom donation amount
  final TextEditingController customDonationController =
      TextEditingController();

  // Controllers for text fields
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController nameOnCardController = TextEditingController();
  final TextEditingController expDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed from the widget tree
    cardNumberController.dispose();
    nameOnCardController.dispose();
    expDateController.dispose();
    cvvController.dispose();
    customDonationController.dispose();
    super.dispose();
  }

  void selectAmount(int amount) {
    // Update the selected donation amount and clear custom amount field
    setState(() {
      selectedAmount = amount;
      customDonationController.clear();
    });
  }

  void setCustomAmount(String amount) {
    // Update the selected donation amount with the custom amount entered
    setState(() {
      selectedAmount = int.tryParse(amount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate Money'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: nameOnCardController,
                decoration: const InputDecoration(
                  labelText: 'Name on card',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card number',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: expDateController,
                      decoration: const InputDecoration(
                        labelText: 'Exp date (MM/YY)',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: TextField(
                      controller: cvvController,
                      decoration: const InputDecoration(
                        labelText: 'CVV',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select amount of donation',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 8.0, // Horizontal space between buttons
                runSpacing: 8.0, // Vertical space between lines
                children: donationAmounts.map((amount) {
                  return ElevatedButton(
                    onPressed: () => selectAmount(amount),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedAmount == amount
                          ? Colors.deepPurple
                          : Colors.grey[200], // Highlight the selected button
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30.0), // Rounded corners
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0), // Button padding
                    ),
                    child: Text(
                      '$amount Dirhams',
                      style: TextStyle(
                        color: selectedAmount == amount
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                child: TextField(
                  controller: customDonationController,
                  decoration: InputDecoration(
                    labelText: 'Enter custom amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20), // Reduced padding for smaller height
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => setCustomAmount(value),
                  style: TextStyle(
                      height: 1.0), // Adjusts the line height if necessary
                )),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  //Navigate to home page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple, // Button background color
                  elevation: 5, // Button elevation
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(200), // Button border radius
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 35), // Button padding
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold, // Text style
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
