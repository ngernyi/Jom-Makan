import 'package:flutter/material.dart';
import 'package:good_food/features/auth_modul/provider/auth_provider.dart';
import 'package:good_food/features/common_widget/long_button.dart';
import 'package:provider/provider.dart';

class auth_signup_last extends StatefulWidget {
  const auth_signup_last({super.key});

  @override
  State<auth_signup_last> createState() => _auth_signup_lastState();
}

class _auth_signup_lastState extends State<auth_signup_last> {
  @override
  Widget build(BuildContext context) {
    double screenVertical = MediaQuery.of(context).size.height;
    double screenHorizontal = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: screenHorizontal * 0.05),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Welcome for using Jom Makan!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              GestureDetector(
                child: long_button(
                  button_name: "Confirm", 
                  backgroundColor: Colors.blue, 
                  textColor: Colors.white, 
                  height: screenVertical * 0.07,),
                
                onTap: () {
                  // save user info in firebase
                  Provider.of<authProvider>(context, listen: false).saveUserData();
                  Navigator.pushNamed(context, '/home');
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}