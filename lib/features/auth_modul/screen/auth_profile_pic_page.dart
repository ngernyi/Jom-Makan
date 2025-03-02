import 'package:flutter/material.dart';
import 'package:good_food/features/auth_modul/provider/auth_provider.dart';
import 'package:good_food/features/auth_modul/screen/auth_signup_last.dart';
import 'package:good_food/features/common_widget/long_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class auth_profile_pic_page extends StatefulWidget {
  const auth_profile_pic_page({super.key});

  @override
  State<auth_profile_pic_page> createState() => _auth_profile_pic_pageState();
}

class _auth_profile_pic_pageState extends State<auth_profile_pic_page> {
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: screenHorizontal*0.05, vertical: screenVertical*0.1),
        child: Column(
          children: [
            // 1. Title
            Text(
              "Add a photo",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
            ),

            // 2. Description
            Text(
              "Add a photo to let people know you! \n Compulsory for every drivers",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,),
            ),

            // 3. Picture avatar
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://media.istockphoto.com/id/1495088043/vector/user-profile-icon-avatar-or-person-icon-profile-picture-portrait-symbol-default-portrait.jpg?s=612x612&w=0&k=20&c=dhV2p1JwmloBTOaGAtaA3AW1KSnjsdMt7-U_3EZElZ0=',
              ),
            ),

            Expanded(child: SizedBox(height: 1,)),

            // 4. choose one button
            GestureDetector(
              onTap: (){
                Provider.of<authProvider>(context, listen: false).setProfileImage();
              },
              child: long_button(
                button_name: "Choose a Photo", 
                backgroundColor: Colors.blue, 
                textColor: Colors.white, 
                height: screenVertical*0.07),
            ),

            // 5. Skip Now Button or Create an account button
            if(Provider.of<authProvider>(context, listen: false).profileImage != null)
            GestureDetector(
              onTap: (){
                Provider.of<authProvider>(context, listen: false).saveUserData();
                Navigator.pushNamed(context, '/home');
              },
              child: long_button(
                button_name: "Continue",
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                height: screenVertical*0.07),
            ),

            GestureDetector(
              onTap: (){          
                Navigator.push(context, MaterialPageRoute(builder: (context) => auth_signup_last()));
              },
              child: long_button(
                button_name: "Skip for now", 
                backgroundColor: Color.fromARGB(255, 218, 218, 218), 
                textColor: Colors.grey, 
                height: screenVertical*0.07),
            ),

          ],
        ),
      ),
    );
  }
}