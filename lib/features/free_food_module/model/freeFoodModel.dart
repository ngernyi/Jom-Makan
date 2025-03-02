import 'package:cloud_firestore/cloud_firestore.dart';

class FreeFoodModel{
  final String? donationId; // Can be null when creating new donations
  final String foodName;
  final int amountDonated;
  int amountLeft;
  final List<String> location;
  final Timestamp time;
  final String description;
  final String donatedFoodImageUrl;
  final String status;
  final List<String> claimedBy;

  FreeFoodModel({
    required this.donationId,
    required this.foodName,
    required this.amountDonated,
    required this.amountLeft,
    required this.location,
    required this.time,
    required this.description,
    required this.donatedFoodImageUrl,
    required this.status,
    required this.claimedBy,
  });

  // convert firestore document snapshot to model
  factory FreeFoodModel.toModel(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  
    return FreeFoodModel(
      donationId: doc.id,
      foodName: data['food_name'] ?? '',
      amountDonated: data['amount_donated'] ?? 0,
      amountLeft: data['amount_left'] ?? 0,
      location: List<String>.from(data['location'] ?? []), // Ensure location is a list
      time: data['time'] ?? Timestamp.now(),
      description: data['description'] ?? '',
      donatedFoodImageUrl: data['donated_food_image_url'] ?? '',
      status: data['status'] ?? 'Available',
      claimedBy: List<String>.from(data['claimed_by'] ?? []),
    );
  }

  // convert model to json
  Map<String, dynamic> toJson() {
    return {
      'food_name': foodName,
      'amount_donated': amountDonated,
      'amount_left': amountLeft,
      'location': location,
      'time': time,
      'description': description,
      'donated_food_image_url': donatedFoodImageUrl,
      'status': status,
      'claimed_by': claimedBy,
    };
  }

  // update donation amount left
  void updateDonationAmountLeft(int amountLeft) {
    this.amountLeft = amountLeft-1;
  }

}