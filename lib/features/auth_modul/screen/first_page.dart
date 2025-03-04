import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:good_food/features/auth_modul/provider/auth_provider.dart';
import 'package:good_food/features/auth_modul/screen/auth_fill_info_page.dart';
import 'package:good_food/features/common_widget/Image_container.dart';
import 'package:good_food/features/common_widget/long_button.dart';
import 'package:provider/provider.dart';

class first_page extends StatefulWidget {
  const first_page({super.key});

  @override
  State<first_page> createState() => _first_pageState();
}

class _first_pageState extends State<first_page> {
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: screenHorizontal*0.05), 
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 1. logo
          Container(
            height: screenVertical*0.1,
            width: screenHorizontal*0.3,
            child: ImageContainer(),
          ),
          SizedBox(height: screenVertical*0.05,),
          // 2. Title
          Text(
            "Jom Makan!",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenVertical*0.02,),
          // 3. Description
          Text(
            "A simple way to order food with cheaper price.",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenVertical*0.05,),
          // 4. Continue button
          GestureDetector(
            onTap: () {
              Provider.of<authProvider>(context, listen: false).signInWithSiswamail(context);
            },
            child: long_button(
            button_name: "Continue with SiswaMail", 
            backgroundColor: Colors.blue, 
            textColor: Colors.white, 
            height: screenVertical*0.07),
          ),

          
        ],
      ),
    );
  }
}