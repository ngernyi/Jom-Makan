import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Continue with Siswamail

  Future<User?> continueWithSiswamail(BuildContext context) async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      print("google sign in opened");
      if (googleUser == null) {
        print("Google Sign-In failed");
        return null;
      }
      // Verify Siswamail domain
      if (!googleUser.email.endsWith('@siswa.um.edu.my')) {
        // sign out the user
        signOut();
        // Show a dialog if not Siswamail
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Invalid Email"),
              content: Text("Only Siswamail accounts are allowed."),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        
        return null;
      }

      // Sign in with Google
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in into Firebase using google credential
      UserCredential result = await _firebaseAuth.signInWithCredential(credential);
      User? user = result.user;

      // if the user uses siswamail, check if user already exists in the system
      if (user != null) {
        // Check if user already exists in the system
        bool userExists = await checkUserExists(user.email!);
        if (userExists) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/signup');
        }
      }
      return user;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return null;
    }
  }
  
  // Phone number verification
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    // Implement phone number verification logic
  }
  
  // Save user data
  Future<void> saveUserData(User user, String name, String phoneNumber, String profileImageUrl, String faculty, String college) async {
    try {
      // save user data to the users collection
      await _firestore.collection('users').doc(user.uid).set({
        'email': user.email,
        'name' : name,
        'phoneNumber': phoneNumber,
        'profileImageUrl' : profileImageUrl,
        'faculty' : faculty,
        'college' : college,
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      print("Error saving user data: $e");
    }    
  }
  
  // Helper function to check if user exists
  Future<bool> checkUserExists(String email) async {
    try {
      // check if the email already exists in the users collection
      final QuerySnapshot result = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      // return true if the user exists, false otherwise
      return result.docs.isNotEmpty;
    } catch (e) {
      print("Error checking user existence: $e");
      return false;
    }
  }

  // Sign out user
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }
}
