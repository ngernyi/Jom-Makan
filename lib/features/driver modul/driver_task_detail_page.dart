import 'package:flutter/material.dart';
import 'package:good_food/features/common_widget/long_button.dart';
import 'package:good_food/features/driver%20modul/driver_active_task_card.dart';
import 'package:good_food/features/driver%20modul/driver_customer_checklist.dart';

class driver_task_detail_page extends StatefulWidget {
  int condition = 0;

  driver_task_detail_page({required this.condition});
  @override
  State<driver_task_detail_page> createState() => _driver_task_detail_pageState();
}

class _driver_task_detail_pageState extends State<driver_task_detail_page> {
  void _openChecklist(){
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      context: context,
      builder: (context) {
        return driver_customer_checklist();  // This is the filter page as a bottom sheet
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Detail"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              // 1. Basic details card (must have)
              SizedBox(height: 10),
              Text(
                "Delivery Details",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              task_detail_list_card(),
              SizedBox(height: 10,),

              // 2. Available tasks
              // 2.1. accept button
              ...[
                if (widget.condition == 1)
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenHorizontal * 0.05),
                    child: long_button(
                      button_name: "Accept Task",
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      height: 50.0,
                    ),
                  )
              ],

              // 3. scheduled task
              // 3.1 delivery status
              // 3.2 arrived at destination button
              // 3.3 customer payment checklist
              ...[if(widget.condition == 2 || widget.condition == 3)...[
                driver_active_task_card(),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: () {
                    _openChecklist();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: screenHorizontal*0.05),
                    child: long_button(
                    button_name: "View Customr Checklist",
                    backgroundColor: Colors.blue, 
                    textColor: Colors.white, 
                    height: screenVertical*0.07),
                  ),
                )
              ]]

              
            ],
          ),
        ),
      ),
    );
  }
}

class task_detail_list_card extends StatefulWidget {
  const task_detail_list_card({super.key});

  @override
  State<task_detail_list_card> createState() => task_detail_list_cardState();
}

class task_detail_list_cardState extends State<task_detail_list_card> {
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenHorizontal*0.05),
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
          // important details
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                detail_text("Food Name:", "Nasi Goreng", Icons.food_bank_outlined),
                SizedBox(height: 10),
                detail_text("Location of Restaurant:", "Jalan Raya Bandung - Bekasi",Icons.drive_eta),
                SizedBox(height: 10),
                detail_text("Destination:", "Taman Mini Indonesia Indah",Icons.location_on_outlined),
                SizedBox(height: 10),
                detail_text("Session:", "10:00 - 12:00",Icons.schedule_outlined),
                SizedBox(height: 10),
                detail_text("Time Limit:", "2 hours",Icons.timer),
              ],
            ),
          ),
          Divider(color: Colors.blue[800], thickness: 1.5),

          // quantity, deposit, collection of cash, and net income
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                detail_text("Quantity:", "5",Icons.numbers),
                SizedBox(height: 10),
                detail_text("Deposit:", "IDR 20,000",Icons.attach_money),
                SizedBox(height: 10),
                detail_text("Collection of Cash:", "IDR 50,000",Icons.attach_money),
                SizedBox(height: 10),
                detail_text("Net Income:", "IDR 30,000",Icons.attach_money),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

Widget detail_text_icon(String title, String value, IconData iconData, {double size = 16}) {
  return Row(
    children: [
      Icon(iconData, color: Colors.blue[800], size: size),
      SizedBox(width: 10),
      Expanded(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      SizedBox(width: 5),
      Expanded(
        child: Text(
          value,
          style: TextStyle(
            fontSize: size,
            color: Colors.black,
            fontWeight: size > 16 ? FontWeight.bold : null,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}

Widget detail_text(String title, String value, IconData icon) {
  return Row(
    children: [
      Icon(icon, color: Colors.blue[800], size: 24),
      SizedBox(width: 10),
      Expanded(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      SizedBox(width: 5),
      Expanded(
        child: Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
