import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class long_button extends StatelessWidget {
  String button_name;
  Color backgroundColor;
  Color textColor;
  double height;
  // double width;

  long_button({
    required this.button_name,
    required this.backgroundColor,
    required this.textColor,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black26)],
      ),
      child: 
        Center(child: Text(
          button_name,
          style: TextStyle(
            fontSize: 16,
            color: textColor,
            fontWeight: FontWeight.bold
        ),
        ))
    );
  }
}