//offers_page.dart
import 'package:flutter/material.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  int points = 214; // This should be retrieved from your user's data

  late final List<Map<String, dynamic>> offers;

  @override
  void initState() {
    super.initState();
    offers = [
      {
        //Offer for Caribou
        'brand': 'assets/caribou.png',
        'title': 'Buy 1 Get 1 free coffee',
        'points': 250,
        'validity': '01/08/2025',
        'imageHeight': 60.0, // Height for the image
        'imageWidth': 60.0, // Width for the image
      },

      //Offer for Atlantis
      {
        'brand': 'assets/atlantis.png',
        'title': 'Get 15% discount on your entry ticket',
        'points': 650,
        'validity': '31/12/2025',
        'imageHeight': 60.0, // Height for the image
        'imageWidth': 60.0, // Width for the image
      },

      //Offer for VoxCinema

      {
        'brand': 'assets/voxcinema.png',
        'title': 'Get 1 Large popcorn with any movie ticket',
        'points': 300,
        'validity': '29/11/2024',
        'imageHeight': 60.0, // Height for the image
        'imageWidth': 60.0, // Width for the image
      },

      //Offer for Carrefour

      {
        'brand': 'assets/carrefour.png',
        'title': 'Get a 20% discount coupon on your bill',
        'points': 700,
        'validity': '31/05/2026',
        'imageHeight': 60.0, // Height for the image
        'imageWidth': 60.0, // Width for the image
      },

      //Offer for IMG
      {
        'brand': 'assets/img.png',
        'title': 'Get 1 free ticket ',
        'points': 1500,
        'validity': '31/12/2024',
        'imageHeight': 60.0, // Height for the image
        'imageWidth': 60.0, // Width for the image
      },

      //Offer for Nesto
      {
        'brand': 'assets/nesto.png',
        'title': 'Get 30% off on any kitchen appliances ',
        'points': 1600,
        'validity': '30/09/2024',
        'imageHeight': 60.0, // Height for the image
        'imageWidth': 60.0, // Width for the image
      },

      //Offer for Lulu
      {
        'brand': 'assets/lulu.png',
        'title': 'Get 100 dirhams free coupon on your bill',
        'points': 1000,
        'validity': '30/09/2024',
        'imageHeight': 60.0, // Height for the image
        'imageWidth': 60.0, // Width for the image
      },

      //offer for Damas Medical
      {
        'brand': 'assets/damas.png',
        'title': 'Get a free facial session!',
        'points': 700,
        'validity': '31/10/2024',
        'imageHeight': 60.0, // Height for the image
        'imageWidth': 60.0, // Width for the image
      },

      //offer for Nursery
      {
        'brand': 'assets/nursery.png',
        'title': 'Get 15% off on your day care subscription for 3 months',
        'points': 2000,
        'validity': '29/06/2027',
        'imageHeight': 60.0, // Height for the image
        'imageWidth': 60.0, // Width for the image
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offers'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                //Navigate back to points
                Navigator.pop(context);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$points',
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    Image.asset(
                      'assets/money.png',
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Image.asset(
                offer['brand'],
                height: offer['imageHeight'],
                width: offer['imageWidth'],
                fit: BoxFit.contain,
              ), // Brand image
              title: Text(
                offer['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Redeem ${offer['points']} points\nValid till: ${offer['validity']}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              isThreeLine: true,
              trailing: ElevatedButton(
                onPressed: () {
                  // Redeem offer logic
                  redeemOffer(offer['points']);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Background color
                  foregroundColor: Colors.white, // Text color
                  shape: RoundedRectangleBorder(
                    // Rounded corners
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text('Redeem'),
              ),
            ),
          );
        },
      ),
    );
  }

  void redeemOffer(int offerPoints) {
    if (points >= offerPoints) {
      // Proceed with redeeming the offer
      setState(() {
        points -= offerPoints; // Deduct points
        // Record this transaction in the user's history
      });
      // Show a success dialog or navigate to a success page
    } else {
      // Show an error indicating insufficient points
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Insufficient Points'),
          content: Text('You do not have enough points to redeem this offer.'),
        ),
      );
    }
  }
}
