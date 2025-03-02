import 'package:flutter/material.dart';
import 'package:good_food/features/common_widget/long_button.dart';

class auth_choose_kkfac_sheet extends StatefulWidget {
  String kkOrFac;
  String passedInKk;
  String passedInFac;
  auth_choose_kkfac_sheet({super.key, required this.kkOrFac, required this.passedInFac, required this.passedInKk});
  @override
  State<auth_choose_kkfac_sheet> createState() => _auth_choose_kkfac_sheetState();
}

class _auth_choose_kkfac_sheetState extends State<auth_choose_kkfac_sheet> {
  // list of kk to be selected
  List<String> kkList = ["KK1", "KK2", "KK3", "KK4", "KK5", "KK6", "KK7", "KK8", "KK9", "KK10"];
  List<bool> selectedKkList = [false, false, false, false, false, false, false, false, false, false];

  // list of fac to be selected
  List<String> facList = [
    "Faculty of Science", 
    "Faculty of Arts", 
    "Faculty of Commerce", 
    "Faculty of Law", 
    "Faculty of Education", 
    "Faculty of Computer Science",
    "Faculty of Engineering", 
    "Faculty of Architecture", 
    "Faculty of Management"
  ];
  List<bool> selectedFacList = [false, false, false, false, false, false, false, false, false];

  // list to be shown after receiving the input
  List<String> listToShow = [];
  List<bool> selectedList = [];
  
  @override
  void initState() {
    super.initState();
    // Update the selectedList based on the initial selectedKKFac
    for (int i = 0; i < kkList.length; i++) {
      if (widget.passedInKk.contains(kkList[i])) {
        selectedKkList[i] = true;
      }
    }

    for (int i = 0; i < facList.length; i++) {
      if (widget.passedInFac.contains(facList[i])) {
        selectedFacList[i] = true;
      }
    }

    // Set the initial listToShow and selectedList based on the input
    if (widget.kkOrFac =="kk") {
      // kk will be shown
      listToShow = kkList;
      selectedList = selectedKkList;
    }  else {
      // fac will be shown
      listToShow = facList;
      selectedList = selectedFacList;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(20),
      height: screenVertical * 0.8,
      width: screenHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // 1. Title text
          Text(
            widget.kkOrFac == "kk" ? "Select your College" : "Select your Faculty",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),

          // 2. Listview
          Expanded(
            child: ListView.builder(
              itemCount: listToShow.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedList[index] = !selectedList[index];
                      for (int i = 0; i < listToShow.length; i++) {
                        if (i != index) {
                          selectedList[i] = false;
                        }
                      }
                    });
                  },
                  child: FilterChoiceButton(
                    name: listToShow[index],
                    isPressed: selectedList[index],
                  ),
                );
              },
            ),
          ),
          
          // 3. Confirm button
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              String selectedValue = "";
              
              for (int i = 0; i < listToShow.length; i++) {
                if (selectedList[i]) {
                  selectedValue = listToShow[i];
                }
              }
              
              Navigator.pop(context, selectedValue);
            },
            child: long_button(
              button_name: "Confirm",
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              height: screenVertical * 0.06,
            ),
          ),
        ],
      ),
    );
  }
}

class FilterChoiceButton extends StatelessWidget {
  final String name;
  final bool isPressed;

  FilterChoiceButton({required this.name, required this.isPressed});

  @override
  Widget build(BuildContext context) {
    double screenVertical = MediaQuery.of(context).size.height;
    double screenHorizontal = MediaQuery.of(context).size.width;

    return AnimatedContainer(
      margin: EdgeInsets.symmetric(vertical: screenVertical * 0.01),
      height: screenVertical * 0.07,
      width: screenHorizontal * 0.9,
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: isPressed ? Colors.blue : Colors.white,
        border: Border.all(
          color: isPressed ? Colors.blue : Colors.black,
          width: isPressed ? 2.0 : 1.0,
        ),
        boxShadow: isPressed
            ? [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 5, spreadRadius: 1)]
            : [],
      ),
      padding: EdgeInsets.symmetric(
        vertical: screenVertical * 0.02,
        horizontal: screenHorizontal * 0.05,
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            color: isPressed ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}