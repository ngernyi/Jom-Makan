import 'package:flutter/material.dart';

class searchBar extends StatefulWidget {
  String searchHints;
  double width;
  TextEditingController controller;
  ValueChanged onChanged;
  searchBar({super.key, required this.width, required this.searchHints, required this.controller, required this.onChanged});

  @override
  State<searchBar> createState() => _searchBarState();
}

class _searchBarState extends State<searchBar> {
  // Search hints
  
  @override
  Widget build(BuildContext context) {
    double screenVertical = MediaQuery.of(context).size.height;
    double screenHorizontal = MediaQuery.of(context).size.width;
    return Container(
      width: screenHorizontal* widget.width,
      height: screenVertical*0.06,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        
      ),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.searchHints,
          border: InputBorder.none,
          icon: Icon(Icons.search),
        ),
      ),
    );
  }
}