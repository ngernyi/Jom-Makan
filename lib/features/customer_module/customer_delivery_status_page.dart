import 'package:flutter/material.dart';
import 'package:good_food/features/common_widget/map_full_screen.dart';
import 'package:good_food/features/customer_module/cutomer_delivery_detail_sheet.dart';
import 'package:good_food/features/free_food_module/model/freeFoodModel.dart';

class customer_delivery_status_page extends StatefulWidget {

  List<FreeFoodModel> freeFood = [];

  @override
  State<customer_delivery_status_page> createState() => _customer_delivery_status_pageState();
}

class _customer_delivery_status_pageState extends State<customer_delivery_status_page> {
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          // 1. Map
          map_full_screen(freeFoodList: widget.freeFood),

          // 2. delivry status card
          Positioned(
            bottom: screenVertical*0.05,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: screenHorizontal*0.05),
              child: delivery_status_card(
              status: "Delivering your food", 
              estimatedTime: "11.00PM", 
              estimatedDuration: "50 Minutes", 
              description: "The driver is delivering your food!"
              )),
            ),

          // 3. back button
          Positioned(
            top: screenVertical*0.1,
            left: screenHorizontal*0.05,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.chevron_left_outlined,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            )
          ),

          // 4. Help button
          Positioned(
            top: screenVertical*0.1,
            right: screenHorizontal*0.05,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.question_mark,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}

class delivery_status_card extends StatefulWidget {
  String status;
  String estimatedTime;
  String estimatedDuration;
  String description;

  delivery_status_card({required this.status, required this.estimatedTime, required this.estimatedDuration, required this.description});

  @override
  State<delivery_status_card> createState() => _delivery_status_cardState();
}

class _delivery_status_cardState extends State<delivery_status_card> {

  void _openDetailsCard(){
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      context: context,
      builder: (context) {
        return customer_delivery_details_sheet();  
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Container(
      width: screenHorizontal*0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // 1. Status
            Text(
              widget.status,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),

            SizedBox(height: 10,),

            // 2. Estimated Time
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Estimated Time Arrival: ",
                  style: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                    color: Colors.grey
                  ),
                ),
                Text(
                  widget.estimatedTime,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
              ],
            ),
            SizedBox(height: 30,),

            // Progress bar
            Stack(
              children: [
                Positioned(
                  // left: 40,
                  // right: 40,
                  child: LinearProgressIndicator(
                    value: 0.5,
                    color: Colors.blue,
                    backgroundColor: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    round_progress(icon: Icons.search, progress_past: true),
                    round_progress(icon: Icons.soup_kitchen_outlined, progress_past: true),
                    round_progress(icon: Icons.delivery_dining_outlined, progress_past: false),
                    round_progress(icon: Icons.doorbell_outlined, progress_past: false),
                  ],
                ),
              ],
            ),
            
            SizedBox(height: 10,),

            // 4. Description
            Text(
              widget.description,
              style: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                    color: Colors.grey
                  ),
            ),
            SizedBox(height: 10,),
            
            // 5. clickable view detials
            Divider(),
            GestureDetector(
              onTap: _openDetailsCard,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // View all Details Text
                  Text(
                    "View All Details",
                    style: TextStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                      color: Colors.grey
                    ),
                  ),

                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}


class round_progress extends StatefulWidget {
  IconData icon;
  bool progress_past;

  round_progress({required this.icon, required this.progress_past});
  @override
  State<round_progress> createState() => _round_progressState();
}

class _round_progressState extends State<round_progress> {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -20),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: widget.progress_past ? Colors.blue: Colors.grey,
        child: Center(
          child: Icon(
            widget.icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class progressbar extends StatefulWidget {
  bool progress_past;

  progressbar({required this.progress_past});

  @override
  State<progressbar> createState() => _progressbarState();
}

class _progressbarState extends State<progressbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      decoration: BoxDecoration(
        color: widget.progress_past ? Colors.blue: Colors.grey,
      ),
    );
  }
}