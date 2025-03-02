import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';

class CloudinaryService {
  static final CloudinaryPublic cloudinary = CloudinaryPublic(
    'dqjdftbuy',  // Replace with your Cloudinary cloud name
    'jom_makan!',  // Replace with your upload preset
    cache: false,
  );

  Future<String?> uploadImageToCloudinary(String filePath) async {
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(filePath, resourceType: CloudinaryResourceType.Image),
      );
      return response.secureUrl; // Return the uploaded image URL
    } catch (e) {
      print("Cloudinary upload error: $e");
      return null;
    }
  }
}
