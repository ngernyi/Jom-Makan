import 'package:flutter/material.dart';
import 'package:good_food/features/auth_modul/provider/auth_provider.dart';
import 'package:good_food/features/common_widget/long_button.dart';
import 'package:provider/provider.dart';

class setting_main_page extends StatefulWidget {
  const setting_main_page({super.key});

  @override
  State<setting_main_page> createState() => _setting_main_pageState();
}

class _setting_main_pageState extends State<setting_main_page> {
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Provider.of<authProvider>(context, listen: false).signOut();
                Navigator.pushNamed(context, '/');
              },
              child: long_button(
                button_name: "Log Out", 
                backgroundColor: Colors.blue, 
                textColor: Colors.white, 
                height: screenVertical*0.07),
            )
          ],
        ),
      ),
    );
  }
}