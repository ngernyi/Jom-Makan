import 'package:flutter/material.dart';
import 'package:good_food/features/auth_modul/provider/auth_provider.dart';
import 'package:good_food/features/auth_modul/screen/auth_choose_kk_fac_bottomsheet.dart';
import 'package:good_food/features/auth_modul/screen/auth_profile_pic_page.dart';
import 'package:good_food/features/auth_modul/screen/auth_verify_phone_page.dart';
import 'package:good_food/features/common_widget/long_button.dart';
import 'package:good_food/features/common_widget/text_field.dart';
import 'package:provider/provider.dart';

class auth_fill_info_page extends StatefulWidget {
  @override
  State<auth_fill_info_page> createState() => _auth_fill_info_pageState();
}

class _auth_fill_info_pageState extends State<auth_fill_info_page> {
  bool _isChecked = false;
  String kk = "";
  String faculty = "";

  void _showFacultyBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return auth_choose_kkfac_sheet(
          kkOrFac: "fac", 
          passedInFac: faculty,
          passedInKk: kk,
        );
      },
    );

    // if the result is not null, update the faculty
    if (result != null) {
      setState(() {
        faculty = result;
      });
    }
  }

  void _showKkBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return auth_choose_kkfac_sheet(
          kkOrFac: "kk", 
          passedInFac: faculty,
          passedInKk: kk,
        );
      },
    );

    // if the result is not null, update the kk
    if (result != null) {
      setState(() {
        kk = result;
      });
    }
  }
  void _showTermsAndConditions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Terms and Conditions",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Here are the terms and conditions...",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Scaffold(
      
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: screenHorizontal * 0.05),
        padding: EdgeInsets.only(top: screenVertical * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "Set up your account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: screenVertical * 0.01),
              // Description
              Text(
                "Fill in your information to set up your account",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: screenVertical * 0.03),
              // 1. Name
              text_field_title(title: "Name"),
              text_field(
                controller: Provider.of<authProvider>(context).nameController,
                hintText: "Enter your name",
                inputFormatters: [],
                keyboardType: TextInputType.text,
                maxLines: 1,
                container_height: screenVertical * 0.07,
              ),
              SizedBox(height: screenVertical * 0.02),
              // 2. Phone Number
              text_field_title(title: "Phone Number"),
              text_field(
                controller: Provider.of<authProvider>(context).phoneController,
                hintText: "+60 ",
                inputFormatters: [],
                keyboardType: TextInputType.phone,
                maxLines: 1,
                container_height: screenVertical * 0.07,
              ),
              SizedBox(height: screenVertical * 0.02),
              // 3. Faculty
              text_field_title(title: "Faculty"),
              GestureDetector(
                onTap: () => _showFacultyBottomSheet(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: screenHorizontal * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  height: screenVertical * 0.07,
                  width: screenHorizontal * 0.9,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                    faculty == "" ? "Select your faculty" : faculty,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  )
                ),
              ),
              SizedBox(height: screenVertical * 0.02),

              // 4. KK
              text_field_title(title: "Residential College"),
              GestureDetector(
                onTap: () => _showKkBottomSheet(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: screenHorizontal * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  height: screenVertical * 0.07,
                  width: screenHorizontal * 0.9,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                    kk == "" ? "Select your residential college" : kk,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  )
                ),
              ),
              SizedBox(height: screenVertical * 0.02),

              // 4. Agreement
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = !_isChecked;
                      });
                    },
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _showTermsAndConditions(context);
                      },
                      child: Text(
                        "I agree to the terms and conditions",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenVertical * 0.03),
              // 5. Submit Button
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (_isChecked) {
                      // save the faculty and college result to provider
                      Provider.of<authProvider>(context, listen: false).setFaculty(faculty);
                      Provider.of<authProvider>(context, listen: false).setCollege(kk);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => auth_profile_pic_page()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please agree to the terms and conditions")),
                      );
                    }
                  },
                  child: long_button(
                    button_name: "Submit",
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    height: screenVertical * 0.07,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class text_field_title extends StatelessWidget {
  final String title;

  text_field_title({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}