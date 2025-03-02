import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final String dorm;
  final Timestamp createdAt;
  final List<String> donationHistory;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.dorm,
    required this.createdAt,
    required this.donationHistory,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      dorm: json['dorm'],
      createdAt: json['createdAt'],
      donationHistory: List<String>.from(json['donationHistory']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'dorm': dorm,
      'createdAt': createdAt,
      'donationHistory': donationHistory,
    };
  }
}
