import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:good_food/features/free_food_module/screen/add_free_food_page.dart';
import 'package:good_food/features/common_widget/long_button.dart';

class filter_page extends StatefulWidget {

  // variable passed in 
  List<String> passedlocation;
  String passedDistance;
  /*---------------------------------*/
  List<String> locationList = ["KK7","KK8", "KK9", "KK10", "KK11", "KK12"];
  List<bool> selectedLocationList = [false, false,false,false,false,false];

  List<String> distanceList = ["0.5km","1km", "2km",];
  int selectedDistance = -1;

  /*---------------------------------*/
  // function to update the list to match with data passed in
  void updateList(){
    // update the location list
    for (var i = 0; i < locationList.length; i++) {
      if(passedlocation.contains(locationList[i])){
        selectedLocationList[i] = true;
      }
    }

    // update the distance list
    if(passedDistance == "0.5km"){
      selectedDistance = 0;
    }
    else if(passedDistance == "1km"){
      selectedDistance = 1;
    }
    else if(passedDistance == "2km"){
      selectedDistance = 2;
    }
  }

  filter_page({required this.passedlocation, required this.passedDistance});


  @override
  State<filter_page> createState() => _filter_pageState();
  
}

class _filter_pageState extends State<filter_page> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.updateList();
  }
  
  @override
  Widget build(BuildContext context) {
    double screenVertical = MediaQuery.of(context).size.height;
    double screenHorizontal = MediaQuery.of(context).size.width;
    return Container(
      height: screenVertical*0.7,
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // 1. Filter Title
          const Text(
            "Filter",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10,),
          Divider(),

          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [// 2. Location
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Location",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),           
            ),
          ),
          SizedBox(height: 10),

          Wrap(
            runSpacing: 10,
            spacing: 10,
            children: List.generate(widget.selectedLocationList.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.selectedLocationList[index] = !widget.selectedLocationList[index]; // Toggle selection
                  });
                },
                child: FilterChoiceButton(
                  name: widget.locationList[index], // You can modify this to be dynamic if needed
                  isPressed: widget.selectedLocationList[index],
                ),
              );
            }),
          ),

          SizedBox(height: 10,),
          // 3. Distance
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Distance",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),           
            ),
          ),
          SizedBox(height: 10,),
          Wrap(
            runSpacing: 10,
            spacing: 10,
            children: List.generate(3, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if(widget.selectedDistance == index.toInt()){
                      widget.selectedDistance = -1;
                    }
                    else{
                      widget.selectedDistance = index.toInt(); 
                    }
                  });
                },
                child: FilterChoiceButton(
                  name: widget.distanceList[index], 
                  isPressed: widget.selectedDistance == index.toInt() ? true : false,
                ),
              );
            }),
          ),
          SizedBox(height: 10,),


          // 4. Reset Button
          GestureDetector(
            child: long_button(
              button_name: "Reset",
              textColor: Colors.white, 
              backgroundColor: Colors.red,
              height: screenVertical*0.08,
            ),
            onTap: () {
              setState(() {
                // remove all location choices
                for (var i = 0; i < widget.selectedLocationList.length; i++) {
                  widget.selectedLocationList[i] = false;
                }

                // remove the distance choice
                widget.selectedDistance = -1;
              });
            },
          ),

          // 5.apply button
          GestureDetector(
            onTap: () {
              // preprocess the data passed
              List<String> selectedLocationString = [];
              for (var i = 0; i < widget.selectedLocationList.length; i++) {
                if(widget.selectedLocationList[i] == true){
                  selectedLocationString.add(widget.locationList[i]);
                }
              }
              String selectedDistanceString = "";
              if(widget.selectedDistance != -1){
                selectedDistanceString = widget.distanceList[widget.selectedDistance];
              }
              Navigator.pop(context,{
                "selectedLocationList": selectedLocationString,
                "selectedDistance": selectedDistanceString,});
            },
            child: long_button(
              button_name: "Apply", 
              textColor: Colors.white, 
              backgroundColor: Colors.blue,
              height: screenVertical*0.08,
            ),
          )
          ])
          )
        ],
      ),
    );
  }
}

class FilterChoiceButton extends StatefulWidget {
  bool isPressed;
  String name;

  FilterChoiceButton({this.name = "Location", this.isPressed = false});
  @override
  State<FilterChoiceButton> createState() => _FilterChoiceButtonState();
}

class _FilterChoiceButtonState extends State<FilterChoiceButton> {
  // Track whether the button is pressed

  @override
  Widget build(BuildContext context) {
    double screenVertical = MediaQuery.of(context).size.height;
    double screenHorizontal = MediaQuery.of(context).size.width;

    return AnimatedContainer(
        height: screenVertical * 0.07,
        width: screenHorizontal * 0.27,
        duration: Duration(milliseconds: 200), // Smooth transition for changes
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color:  widget.isPressed? Colors.blue : Colors.white, // Change color on press
          border: Border.all(
            color: widget.isPressed ? Colors.blue : Colors.black, // Border color change
            width: widget.isPressed ? 2.0 : 1.0, // Border width change
          ),
          boxShadow: widget.isPressed
              ? [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 5, spreadRadius: 1)] // Add shadow when pressed
              : [],
        ),
        padding: EdgeInsets.symmetric(
          vertical: screenVertical * 0.02,
          horizontal: screenHorizontal * 0.05,
        ),
        child: Center(
          child: Text(
            widget.name,
            style: TextStyle(
              color: widget.isPressed ? Colors.white : Colors.black, // Text color change
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      
    );
  }
}





