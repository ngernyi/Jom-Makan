import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:good_food/features/free_food_module/provider/addFreeFoodProvider.dart';
import 'package:good_food/features/free_food_module/screen/free_food_filter_page.dart';
import 'package:good_food/features/free_food_module/widgets/free_food_location_selector_sheet.dart';
import 'package:good_food/features/common_widget/long_button.dart';
import 'package:good_food/features/common_widget/text_field.dart';
import 'package:good_food/features/free_food_module/widgets/free_food_view_uploaded_image.dart';
import 'dart:developer';

import 'package:provider/provider.dart';

class add_free_food_page extends StatefulWidget {
  const add_free_food_page({super.key});

  @override
  State<add_free_food_page> createState() => _add_free_food_pageState();
}

class _add_free_food_pageState extends State<add_free_food_page> {

  List<String> selectedLocation = [];

  // function to open location selector when location field is clicked
  void _openLocation() {
    log("open location function called");
    // Show bottom sheet when _openFilter is true
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      context: context,
      builder: (context) {
        return free_food_location_selector_sheet(selectedLocation: selectedLocation);  // This is the filter page as a bottom sheet
      },
    ).then((value) => setState(() {
      if (value != null) {
        setState(() {
          selectedLocation = value;
        });
      }
    }));
  }



  // function to open date time picker when date and time field is clicked

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  late DateTime selectedDateTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
    final TimeOfDay? pickedd = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedd != null && pickedd != selectedTime) {
      setState(() {
        selectedTime = pickedd;
      });
    }
    selectedDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }


  @override
  Widget build(BuildContext context) {
    double screenVertical = MediaQuery.of(context).size.height;
    double screenHorizontal = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (_) => addFreeFoodProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Free Food"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),

        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: screenHorizontal*0.1),
            padding: EdgeInsets.symmetric(vertical: screenVertical*0.03),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                // title
                question_title(keywords: "Food Name"),
                text_field(
                  controller: context.read<addFreeFoodProvider>().foodNameController,
                  hintText: "Enter Food Name", 
                  inputFormatters: [], 
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  container_height: 50,
                ),

                // Amount
                question_title(keywords: "Amount"),
                text_field(
                  controller: context.read<addFreeFoodProvider>().amountDonatedController,
                  hintText: "Enter Amount", 
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly], 
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  container_height: 50,
                ),

                // Location
                question_title(keywords: "Location"),
                GestureDetector(
                  onTap: (){
                    _openLocation();
                  },
                  child: elevated_button_field(hintText: "Select Location",),
                ),

                // Date and Time
                question_title(keywords: "Date and Time"),
                GestureDetector(
                  onTap: (){
                    _selectDate(context);
                  },
                  child: elevated_button_field(hintText: "Select Date and Time",),
                ),

                // Description
                question_title(keywords: "Description"),
                text_field(
                  controller: context.read<addFreeFoodProvider>().descriptionController,
                  hintText: "Add Description", 
                  inputFormatters: [], 
                  keyboardType: TextInputType.text, 
                  maxLines: 5,
                  container_height: 150,
                ),

                // upload image
                question_title(keywords: "Upload Image"),
                GestureDetector(
                  onTap: (){
                    context.read<addFreeFoodProvider>().selectImage();
                  },
                  child: const upload_image_button(),
                ),

                // uploaded image
                if(context.watch<addFreeFoodProvider>().selectedImage != null)
                uploaded_image(
                  image_name: context.watch<addFreeFoodProvider>().imageName,
                  viewTap: () {
                    showDialog(
                      context: context, 
                      builder: (BuildContext context){
                        return Container(
                          child:  FreeFoodViewUploadedImage(selectedImage: context.watch<addFreeFoodProvider>().selectedImage!,)
                        );
                        
                      });
                  },
                  removeTap: (){
                    context.read<addFreeFoodProvider>().deleteImage();
                  },
                ),
                

                // sized box
                SizedBox(height: 10),
                // submit button
                GestureDetector(
                  onTap: () async{
                    await context.read<addFreeFoodProvider>().addFreeFood(selectedDateTime,selectedLocation);
                    Navigator.pop(context);
                  },
                  child: long_button(
                    button_name: "Submit", 
                    textColor: Colors.white, 
                    backgroundColor: Colors.blue,
                    height: screenVertical*0.08,
                  ),
                ),

              ],
            )
          ),
        ),
      ),
    );
  }
}


class question_title extends StatelessWidget {
  String keywords;

  question_title({required this.keywords});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        keywords,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          
        ),
        maxLines: 1,
        textAlign: TextAlign.left,
      ),  
    );
  }
}

class elevated_button_field extends StatefulWidget {
  String hintText;
  
  elevated_button_field({required this.hintText});

  @override
  State<elevated_button_field> createState() => _elevated_button_fieldState();
}

class _elevated_button_fieldState extends State<elevated_button_field> {
   @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black26)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.hintText,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Icon(
            Icons.arrow_drop_down
          ),
        ],
      )
    );
  }
}

class location_field extends StatefulWidget {
  const location_field({super.key});

  @override
  State<location_field> createState() => _location_fieldState();
}

class _location_fieldState extends State<location_field> {
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black26)],
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Select Location",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Icon(
            Icons.arrow_drop_down
          ),
        ],
      )
    );
  }
}

class upload_image_button extends StatelessWidget {
  const upload_image_button({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 192, 192, 192)),
        color: Color.fromARGB(255, 178, 212, 239),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black26)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Upload Image",
            style: TextStyle(
              fontSize: 16,
              color: const Color.fromARGB(255, 75, 165, 239),
              fontWeight: FontWeight.bold
            ),
          ),
          Icon(
            Icons.upload,
            color:  const Color.fromARGB(255, 75, 165, 239),
          ),
        ],
      )
    );
  }
}

class uploaded_image extends StatelessWidget {
  String image_name;
  VoidCallback viewTap;
  VoidCallback removeTap;

  uploaded_image({required this.image_name, required this.viewTap, required this.removeTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // 1. check icon
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 10),

          // 2. image name
          GestureDetector(
            child: Text(
              image_name,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
            onTap: (){
              viewTap();
            },
          ),
          Expanded(
            child: SizedBox(
              width: 50,
            )
          ),

          // 3. remove icon
          GestureDetector(
            child: Icon(Icons.delete, color: Colors.black),
            onTap: (){
              removeTap();
            },
          )
        ],
      ),
    );
  }
}

