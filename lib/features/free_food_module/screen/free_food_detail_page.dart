import 'package:flutter/material.dart';
import 'package:good_food/features/free_food_module/model/freeFoodModel.dart';
import 'package:good_food/features/free_food_module/widgets/free_food_detail_card.dart';
import 'package:good_food/features/free_food_module/widgets/free_food_picture.dart';
import 'package:good_food/features/common_widget/long_button.dart';

class free_food_details_page extends StatefulWidget {
  FreeFoodModel freeFood;
  free_food_details_page({super.key, required this.freeFood});

  @override
  State<free_food_details_page> createState() => _free_food_details_pageState();
}

class _free_food_details_pageState extends State<free_food_details_page> {
  @override
  /// Builds the UI for the Free Food Details page.
  ///
  /// This method returns a [Scaffold] widget containing an [AppBar] with a
  /// title and a back button. The body consists of a [SingleChildScrollView]
  /// with a [Column] that displays an image and a detail card, followed by
  /// two buttons: "Report" and "Take one". The layout is responsive to the
  /// screen size, adjusting the image size and padding accordingly.

  Widget build(BuildContext context) {
    double screenVertical = MediaQuery.of(context).size.height;
    double screenHorizontal = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.freeFood.foodName),
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
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Column(
            children: [
              // Image
              Container(
                height: screenVertical*0.3,
                width: screenHorizontal,
                child: free_food_picture(imageUrl: widget.freeFood.donatedFoodImageUrl),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: screenHorizontal*0.1),
                child: Column(
                  children: [
                    // Details
              
                    free_food_detail_card(freeFood: widget.freeFood,),

                    // report button
                    long_button(
                      button_name: "Report", 
                      backgroundColor: Colors.red, 
                      textColor: Colors.white,
                      height: screenVertical*0.08,
                    ),

                    long_button(
                      button_name: "Take one", 
                      backgroundColor: Colors.blue, 
                      textColor: Colors.white,
                      height: screenVertical*0.08,
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      )
    );
  }
}