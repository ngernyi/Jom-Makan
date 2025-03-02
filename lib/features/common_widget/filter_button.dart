import 'package:flutter/material.dart';

class filter_button extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    double screenVertical = MediaQuery.of(context).size.height;
    double screenHorizontal = MediaQuery.of(context).size.width;
    
    return Container(       
      height: screenVertical*0.06,
      width: screenVertical*0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.blue,
      ),
      child: Icon(
        Icons.filter_alt_outlined,
        color: Colors.white,
        
      ),
    );

    
  }
}