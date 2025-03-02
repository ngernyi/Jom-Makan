import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class text_field extends StatefulWidget {
  TextEditingController controller;
  String hintText;
  List<TextInputFormatter> inputFormatters;
  TextInputType keyboardType;
  int maxLines;
  double container_height;

  text_field({
    required this.controller,
    required this.hintText, 
    required this.inputFormatters, 
    required this.keyboardType, 
    required this.maxLines,
    required this.container_height,
  });

  @override
  State<text_field> createState() => _text_fieldState();
}

class _text_fieldState extends State<text_field> {
@override
  Widget build(BuildContext context) { 
    double screenVertical = MediaQuery.of(context).size.height;
    return Container(
      height: widget.container_height,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black26)],
      ),
      child: TextField(
        controller: widget.controller,
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),     
    );
  }
}