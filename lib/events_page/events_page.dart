import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'View',
              style: TextStyle(
                color: Color(0xFF8158D3),
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Events',
              style: TextStyle(
                color: Color(0xFF8158D3),
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20), // Space between title and icon
            const Icon(
              Icons.event_available, // The icon you want to display
              size: 50, // The size of the icon
              color: Color(0xFF8158D3), // The color of the icon
            ),
            const SizedBox(height: 25), // Space between icon and the first item
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: const [
                  EventListItem(
                    title: 'International conference on food 2024',
                    iconData: Icons.location_on,
                  ),
                  SizedBox(height: 10), // Space between items
                  EventListItem(
                    title: 'The Green home',
                    iconData: Icons.location_on,
                  ),
                  SizedBox(height: 10), // Space between items
                  EventListItem(
                    title: 'Food Management Conference',
                    iconData: Icons.location_on,
                  ),
                  SizedBox(height: 10), // Space between items
                  EventListItem(
                    title: 'FoodWise Festival',
                    iconData: Icons.location_on,
                  ),
                  SizedBox(height: 10), // Space between items
                  EventListItem(
                    title: 'Dubai International Food Festival',
                    iconData: Icons.location_on,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventListItem extends StatelessWidget {
  final String title;
  final IconData iconData;

  const EventListItem({
    Key? key,
    required this.title,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(iconData, color: const Color(0xFF8158D3)),
          const SizedBox(width: 16), // Spacing between the icon and text
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
