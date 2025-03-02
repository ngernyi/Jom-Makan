import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/freeFoodModel.dart';
import '../service/freeFoodService.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../../service/cloudinaryService.dart';

class addFreeFoodProvider extends ChangeNotifier{

  // initilaise the firebase
  final FreeFoodService _freeFoodService = FreeFoodService();

  // Cloudinary for image
  final CloudinaryService _cloudinaryService = CloudinaryService();

  // initialse list of free food
  List<FreeFoodModel> _list = [];

  // store image selected
  File? _selectedImage;
  File? get selectedImage => _selectedImage;
  set selectedImage(File? image) => _selectedImage = image;

  // controllers
  TextEditingController foodNameController = TextEditingController();
  TextEditingController amountDonatedController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  
  // getter for searchController
  String get searchTerm => searchController.text;

  // states
  bool isloading = false;

  // getter for free food list (other components in this app can get the list without modifying it)
  List<FreeFoodModel> get freeFoodList{
    return _list;
  }

  void clear() {
    foodNameController.text = "";
    amountDonatedController.text = "";
    locationController.text = "";
    descriptionController.text = "";
    searchController.text = "";
    selectedImage = null;
  }
  void dispose() {
    foodNameController.dispose();
    amountDonatedController.dispose();
    locationController.dispose();
    descriptionController.dispose();

    selectedImage = null;
    super.dispose();
  }

  /* ==============================================================
      Functions related to filter and search
  ================================================================= */

  // filter by location list
  List<FreeFoodModel> filterByLocation(List<String> locationList, List<FreeFoodModel> freeFoodList) {
    return freeFoodList.where((element) {
      // Check if any location in the FreeFoodModel's location list matches the locationList
      return element.location.any((loc) => locationList.contains(loc));
    }).toList();
  }

  // filter by search
  List<FreeFoodModel> searchFreeFood(List<FreeFoodModel> freeFoodList) {
    String searchTerm = searchController.text;
    if (searchTerm == "") {
      return freeFoodList;
    }
    return freeFoodList.where((element) {
      // Check if the search term matches the food name or description
      return element.foodName.toLowerCase().contains(searchTerm.toLowerCase()) ||
             element.description.toLowerCase().contains(searchTerm.toLowerCase());
    }).toList();
  }
  /* ==============================================================
      Functions related to user input
  ================================================================= */

  // select image function
  Future<void> selectImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      notifyListeners();
    } else {
      print('No image selected.');
    }
  }

  // delete image function
  void deleteImage() {
    selectedImage = null;
    notifyListeners();
  }

  // function to get the image name
  String get imageName {
    if (selectedImage != null) {
      return selectedImage!.path.split('/').last;
    }
    return 'No name';
  }

  String? inputValidation(){
    if(selectedImage == null){
      return "Please select an image";
    }
  }

  /* ==============================================================
      Functions related to Firebase
  ================================================================ */

  // upload image function
  // Upload image function using Cloudinary
  Future<String> uploadImage(File imageFile) async {
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

  // add free food function
  Future<void> addFreeFood(DateTime selectedDateTime, List<String> locationList) async {

    // Input Validation
    
    // upload image to storage first to get the url
    String imageUrl = await uploadImage(_selectedImage!);

    // create a freeFood model
    FreeFoodModel freeFood = FreeFoodModel(
      donationId: null,
      foodName: foodNameController.text, 
      amountDonated: int.parse(amountDonatedController.text), 
      amountLeft: int.parse(amountDonatedController.text), 
      location: locationList, 
      time: Timestamp.fromDate(selectedDateTime),
      description: descriptionController.text, 
      donatedFoodImageUrl: imageUrl, 
      status: "available", 
      claimedBy: []
      );
    
    // call the service to add donation
    await _freeFoodService.addDonation(freeFood);  

    // clear the form
    clear();

    log("database saved");

  }

  // update free food amount left function
  Future<void> updateFreeFood(String donationId, int value) async {
    // call the service to update donation amount left
    await _freeFoodService.updateDonation(donationId, value);

  }

  // Fetch all available free food list
  Stream<List<FreeFoodModel>> getAvailableDonationsStream() {
    return _freeFoodService.getAvailableDonations();
  }

  
}