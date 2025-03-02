import 'package:flutter/material.dart';
import 'package:good_food/features/common_widget/long_button.dart';

class driver_active_task_card extends StatefulWidget {
  const driver_active_task_card({super.key});

  @override
  State<driver_active_task_card> createState() => _driver_active_task_cardState();
}

class _driver_active_task_cardState extends State<driver_active_task_card> {
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;  
    return Container(
      
      child: Column(
        children: [
          // 1. Text 
          SizedBox(height: 10,),
          Text(
            "Delivery Status",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
          ),
          SizedBox(height: 10,),
          // 2. status card
          Container(
            margin: EdgeInsets.symmetric(horizontal: screenHorizontal*0.05),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                status_row(past: true, step_name: "Pickup", time: "12:00 PM"), 
                SizedBox(height: 10,),
                status_row(past: false, step_name: "Delivery", time: "12:00 PM"), 
                SizedBox(height: 10,),
                status_row(past: false, step_name: "Arrived", time: "12:00 PM"), 
                SizedBox(height: 10,),
                status_row(past: false, step_name: "Delivered", time: "12:00 PM"), 
              ],
            ),
          )
        ]
      ),
    );
  }
}

class status_row extends StatefulWidget {
  bool past;
  String step_name;
  String time;

  status_row({required this.past, required this.step_name, required this.time});

  @override
  State<status_row> createState() => _status_rowState();
}

class _status_rowState extends State<status_row> {
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: screenHorizontal * 0.3,
          child: CircleAvatar(
            radius: 20,
            backgroundColor: widget.past ? Colors.blue : Colors.grey,
            child: Center(
              child: Icon(
                widget.past ? Icons.done : Icons.timelapse,
                color: Colors.white,
              ),
            ),
          ),
        ),

        Expanded(
          child: Column(
            children: [
              // 1. Status Text
              Text(
                widget.step_name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              ),

              // 2. Time Text or done button
              ...[if(widget.past)
                Text(
                  "Completed at "+widget.time,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14
                  ),
                )
              else
                long_button(
                  button_name: "Complete", 
                  backgroundColor: Colors.blue, 
                  textColor: Colors.white, 
                  height: screenVertical * 0.05,
                )]

            ],
          ),
        )
      ]
    );
  }
}
