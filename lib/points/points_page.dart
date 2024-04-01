// points_page.dart
import 'package:flutter/material.dart';
import 'package:phase_2_implementation/offers/offers_page.dart';

class PointsPage extends StatefulWidget {
  const PointsPage({super.key});

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  String selectedOption = 'Earn More';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Points'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: _buildPointsCircle(),
            ),
            const SizedBox(height: 20),
            _buildRedeemButton(context),
            const SizedBox(height: 30),
            _buildOptionsSection(),
            if (selectedOption == 'Earn More') _buildEarnMoreInfo(),
            if (selectedOption == 'History') _buildHistoryInfo(),
            if (selectedOption == 'Terms & Conditions') _buildTandCInfo(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildRedeemButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to offers page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OffersPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(45),
        ),
      ),
      child: const Text(
        'Redeem F-Points',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPointsCircle() {
    return Container(
      height: 280,
      width: 280,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/points_circle.png'), // Path to your image
          fit: BoxFit.contain,
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Center the column
          children: [
            Text(
              '214', // Points value
              style: TextStyle(
                fontSize: 48, // Large font size for the points value
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Points', // Points text
              style: TextStyle(
                fontSize: 24, // Smaller font size for the word 'Points'
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildOptionButton('Earn More'),
        _buildOptionButton('History'),
        _buildOptionButton('Terms & Conditions'),
      ],
    );
  }

  Widget _buildOptionButton(String option) {
    bool isSelected = selectedOption == option;
    return InkWell(
      onTap: () {
        setState(() {
          selectedOption = option;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[300] : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          option,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

Widget _buildEarnMoreInfo() {
  return Container(
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 243, 238, 189), // A pastel yellow color
      borderRadius: BorderRadius.circular(10), // Rounded corners
    ),
    child: const SingleChildScrollView(
      child: Text(
        "Earn points every time you donate food items through our app. The amount of points you earn depends on the validity of the food item at the time of donation. Our point system is designed to encourage the donation of food items that are still within a useful period before their expiration date. Here's how it works:\n\n"
        "Food Items with 10 Days or More Validity: Earn 15 points for each item. Donating items with longer validity helps ensure they reach those in need in the best condition.\n\n"
        "Food Items with 5 to 9 Days Validity: If the food item you're donating has 5 to 9 days until expiration, you will earn 10 points for each item.\n\n"
        "Food Items with 1 to 4 Days Validity: Donations of items that are closer to their expiration date but still consumable are also valued, earning you 5 points per item.\n\n"
        "Food Items with Less than 1 Day Validity: Even last-minute donations before the expiration can make a difference. These items earn 3 points each.",
        style: TextStyle(
          color: Colors.black, // Text color
          fontSize: 16, // Font size
        ),
      ),
    ),
  );
}

Widget _buildTandCInfo() {
  return Container(
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 248, 200, 217), // A pastel pink color
      borderRadius: BorderRadius.circular(10), // Rounded corners
    ),
    child: const SingleChildScrollView(
      child: Text(
        "Point Expiration: Points may expire if not used within a specified period. Check the expiration date of your points to ensure they are redeemed in time.\n\n"
        "Reward Availability: Rewards are subject to availability and may change over time. \n\n"
        "Non-Transferable: Points and rewards are non-transferable and cannot be exchanged for cash or credit.\n\n"
        "One-Time Use: Each reward can be redeemed only once per transaction. Points will be deducted immediately upon redemption.\n\n"
        "Liability: The app is not responsible for lost or stolen rewards after redemption. Ensure you follow the claim instructions carefully.\n\n"
        "Changes to Terms: The app reserves the right to modify these terms and conditions at any time. Continued use of the points system constitutes acceptance of these changes.",
        style: TextStyle(
          color: Colors.black, // Text color
          fontSize: 16, // Font size
        ),
      ),
    ),
  );
}

Widget _buildHistoryInfo() {
  // Sample data for history entries
  final List<Map<String, dynamic>> historyData = [
    {
      'date': '19 Mar 2024',
      'action': 'Donated 12 items',
      'points': 'Earned 120 points',
      'color': const Color.fromARGB(
          255, 232, 196, 243), // Adjust the color to match your design
    },
    {
      'date': '5 Jan 2024',
      'action': 'Redeemed 200 points',
      'points': 'View transaction',
      'color': const Color.fromARGB(
          255, 243, 199, 227), // Adjust the color to match your design
    },
    {
      'date': '17 Nov 2023',
      'action': 'Donated 6 items',
      'points': 'Earned 94 points',
      'color': const Color.fromARGB(
          255, 242, 238, 195), // Adjust the color to match your design
    },
    // Add more history entries here...
  ];

  return Column(
    children: historyData.map((entry) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: entry['color'],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entry['date'],
              style: const TextStyle(
                color: Color.fromARGB(255, 91, 91, 91),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              entry['action'],
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              entry['points'],
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  // TO DO: Implement view items action
                },
                child: const Text('View items >'),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}
