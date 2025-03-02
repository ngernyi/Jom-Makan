import 'package:flutter/material.dart';
import 'package:good_food/features/auth_modul/screen/auth_profile_pic_page.dart';
import 'package:good_food/features/common_widget/long_button.dart';

class auth_verify_phone_page extends StatefulWidget {
  const auth_verify_phone_page({super.key});

  @override
  State<auth_verify_phone_page> createState() => _auth_verify_phone_pageState();
}

class _auth_verify_phone_pageState extends State<auth_verify_phone_page> {
  final List<TextEditingController> _controllers = List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenHorizontal * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. Title
              const Text(
                "Verify Phone Number",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // 2. Description
              const Text(
                "Enter the OTP sent to +91 9999999999",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // 3. OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: otp_field(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      nextFocusNode: index < 3 ? _focusNodes[index + 1] : null,
                      prevFocusNode: index > 0 ? _focusNodes[index - 1] : null,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // 4. Resend OTP Button with Countdown (Placeholder)
              TextButton(
                onPressed: () {
                  // Resend OTP logic
                },
                child: const Text("Resend Code"),
              ),
              const SizedBox(height: 20),

              // 5. Submit Button
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => auth_profile_pic_page()));
                },
                child: long_button(
                  button_name: "Verify", 
                  backgroundColor: Colors.blue, 
                  textColor: Colors.white, 
                  height: screenVertical*0.07),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

class otp_field extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final FocusNode? prevFocusNode;

  const otp_field({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.prevFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenHorizontal * 0.1,
      height: screenVertical * 0.05,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, color: Colors.black),
        keyboardType: TextInputType.number,
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            nextFocusNode?.requestFocus(); // Move to next field
          } else {
            prevFocusNode?.requestFocus(); // Move back if deleting
          }
        },
      ),
    );
  }
}


