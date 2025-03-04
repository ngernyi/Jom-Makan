import 'package:flutter/material.dart';
import 'package:good_food/features/common_widget/long_button.dart';

class free_food_location_selector_sheet extends StatefulWidget {

  List<String> locationList = ["KK7", "KK8", "KK9", "KK10", "KK11", "KK12","KK13"];
  List<bool> selectedList = [false, false, false, false, false, false, false];

  List<String> selectedLocation;

  free_food_location_selector_sheet({super.key, required this.selectedLocation});

  @override
  State<free_food_location_selector_sheet> createState() => _free_food_location_selector_sheetState();
}

class _free_food_location_selector_sheetState extends State<free_food_location_selector_sheet> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // update the selectedList
    for (int i = 0; i < widget.locationList.length; i++) {
      if (widget.selectedLocation.contains(widget.locationList[i])) {
        widget.selectedList[i] = true;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(20),
      // height: screenVertical * 0.9,
      width: screenHorizontal,
      child: Column(
        children: [
          Text(
            "Select Location",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Select the location where you want to put the free food",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Expanded( // Use Expanded to fill available space
            child: ListView.builder(
              itemCount: widget.locationList.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      // Toggle the selected state of the location card
                      widget.selectedList[index] = !widget.selectedList[index];
                    });
                  },
                  child: location_card(
                    location_name: widget.locationList[index], // Use actual location name
                    selected: widget.selectedList[index],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),

          // confirm button
          GestureDetector(
            onTap: () {
              // update the selectedLocationList
              List<String> selectedLocation = [];
              for (int i = 0; i < widget.locationList.length; i++) {
                if (widget.selectedList[i]) {
                  selectedLocation.add(widget.locationList[i]);
                }
              }
              // update the selectedLocation
              widget.selectedLocation = selectedLocation;
              // close the sheet
              Navigator.pop(context, selectedLocation);
            },
            child: long_button(
              button_name: "Confirm", 
              backgroundColor: Colors.blue, 
              textColor: Colors.white, 
              height: screenVertical * 0.06,
            )
          )
        ],
      ),
    );
  }
}

class location_card extends StatefulWidget {
  String location_name;
  bool selected;

  location_card({required this.location_name, required this.selected});

  @override
  State<location_card> createState() => _location_cardState();
}

class _location_cardState extends State<location_card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.location_name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            widget.selected ? Icons.check_box : Icons.check_box_outline_blank,
          ),
        ],
      )
    );
  }
}