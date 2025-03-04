import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/freeFoodModel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FreeFoodService {

  // initialise freeFood collection
  final freeFoodCollection 
    = FirebaseFirestore.instance.collection('freeFood');


  // Read all donations 
  Stream<List<FreeFoodModel>> getAllDonations() {
    return freeFoodCollection
      .orderBy('time',descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
        .map((doc) => FreeFoodModel.toModel(doc))
        .toList());
  }

  // Read available donations
  Stream<List<FreeFoodModel>> getAvailableDonations() {
    return freeFoodCollection
      .where('amount_left', isGreaterThan: 0)
      .orderBy( 'time', descending: true)
      .snapshots()
      .map((snapshots) => snapshots.docs
        .map((doc) => FreeFoodModel.toModel(doc))
        .toList());
  }

  // Add new donation
  Future<DocumentReference> addDonation(FreeFoodModel FreeFood) {
    return freeFoodCollection.add(FreeFood.toJson());
  }

  // Update donation
  Future<void> updateDonation(String donationId, int value) async {
    await freeFoodCollection.doc(donationId).update({'amountLeft': FieldValue.increment(value)});
  }

  // upload image to firebase storage
  // Future<String> uploadImage(File imageFile) async {
  //   try {
  //     // Create a reference to Firebase Storage
  //     Reference storageReference = FirebaseStorage.instance
  //         .ref()
  //         .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

  //     // Upload the file
  //     UploadTask uploadTask = storageReference.putFile(imageFile);
      
  //     // Wait until the file is uploaded
  //     TaskSnapshot taskSnapshot = await uploadTask;

  //     // Get the download URL
  //     String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      
  //     return downloadUrl;
  //   } catch (e) {
  //     print("Error uploading image: $e");
  //     return "";
  //   }
  // }


}