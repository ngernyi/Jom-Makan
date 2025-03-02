import 'dart:io';

import 'package:flutter/material.dart';
import 'package:good_food/features/common_widget/long_button.dart';

class FreeFoodViewUploadedImage extends StatelessWidget {

  File selectedImage;
  FreeFoodViewUploadedImage({super.key, required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;  
    double screenVertical = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenHorizontal * 0.05, vertical: screenVertical * 0.2),
      padding: EdgeInsets.symmetric(horizontal:  screenHorizontal * 0.05),
      height: screenVertical * 0.5,
      width: screenHorizontal * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 1. text "Uploaded Image"
          Text(
            "Uploaded image",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: screenVertical * 0.02),
          // 2. Image
          Image.file(
            selectedImage,
            height: screenVertical * 0.3,
            width: screenHorizontal * 0.7,
          ),
          SizedBox(height: screenVertical * 0.02),
          // 3. confirm button
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: long_button(
              button_name: "Confirm", 
              backgroundColor: Colors.blue, 
              textColor: Colors.white, 
              height: screenVertical * 0.07,
            ),
          )
        ],
      ),
    );
  }
}