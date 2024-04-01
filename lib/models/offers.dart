//offers.dart
//in models

// lib/models/offer.dart
class Offer {
  final String name;
  final String description;
  final int pointsRequired;
  final DateTime expiryDate;
  final String logoAsset;

  Offer(
      {required this.name,
      required this.description,
      required this.pointsRequired,
      required this.expiryDate,
      required this.logoAsset});
}
