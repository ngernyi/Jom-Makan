import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:good_food/features/auth_modul/service/auth_service.dart';
import 'package:good_food/service/cloudinaryService.dart';
import 'package:image_picker/image_picker.dart';

class authProvider extends ChangeNotifier {
  final CloudinaryService _cloudinaryService = CloudinaryService();
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  // text controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // faculty and college
  String? _faculty;
  String? _college;

  String? get faculty => _faculty;
  String? get college => _college;

  // set faculty and college
  void setFaculty(String faculty) {
    _faculty = faculty;
    notifyListeners();
  }

  void setCollege(String college) {
    _college = college;
    notifyListeners();
  }

  // Profile image
  File? _profileImage;

  File? get profileImage => _profileImage;

  /*------------------------------------------------------------------------*/
   // dispose all the controllers
  /*------------------------------------------------------------------------*/
  void disposeControllers() {
    nameController.text = "";
    phoneController.text = "";
    nameController.dispose();  
    phoneController.dispose();
  }

  /*------------------------------------------------------------------------*/
   // Functions related to user input
  /*------------------------------------------------------------------------*/

  // Method to open image picker and set the profile image
  Future<void> setProfileImage() async{
    // open image picker and select an image
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    // if the user has selected an image
    if (pickedFile != null){
      _profileImage = File(pickedFile.path);
    }
    else{
      // if the user has not selected an image
      _profileImage = null;
      print("no image selected"	);
    }
    notifyListeners();
  }

  /*------------------------------------------------------------------------*/
   // Functions related to Image databae (cloudinary)
  /* ------------------------------------------------------------------------*/

  // Method to upload image to cloudinary
  Future<String> uploadProfileImage(File imageFile) async {
    try {
      String? imageUrl = await _cloudinaryService.uploadImageToCloudinary(imageFile.path);
      if (imageUrl != null) {
        return imageUrl;
      } else {
        throw Exception("Image upload failed.");
      }
    } catch (e) {
      print("Cloudinary upload error: $e");
      throw Exception("Error uploading image: $e");
    }
  }

  /*------------------------------------------------------------------------*/
   // Functions related to firebase
  /*------------------------------------------------------------------------*/

  // Method to sign in with Siswamail
  Future<void> signInWithSiswamail(BuildContext context) async {
    _user = await _authService.continueWithSiswamail(context);
    notifyListeners();
  }

  // Method to sign out
  Future<void> signOut() async {
    _authService.signOut();
    await FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }

  // Function to save the user info to firestore
  Future<void> saveUserData() async {
    // save the image to cloudinary if the user has selected an image
    String imageUrl = "";
    if (_profileImage!= null){
      imageUrl = await uploadProfileImage(_profileImage!);
    }

    // convert controller's text to String
    String name = nameController.text;
    String phoneNumber = phoneController.text;

    // do checking for the input

    // save the info to firebase
    await _authService.saveUserData(_user!, name, phoneNumber, imageUrl, _faculty!, _college!);
    notifyListeners();
  }
}