import 'package:flutter/material.dart';
import 'package:good_food/features/common_widget/filter_button.dart';
import 'package:good_food/features/common_widget/long_button.dart';
import 'package:good_food/features/common_widget/search_bar.dart';
import 'package:good_food/features/driver%20modul/driver_task_detail_page.dart';

class driver_main_page extends StatefulWidget {
  const driver_main_page({super.key});

  @override
  State<driver_main_page> createState() => _driver_main_pageState();
}

class _driver_main_pageState extends State<driver_main_page> {
  List<String> categories = ["Available", "Scheduled", "Delivered"];
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Driver Delivery Task"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: screenHorizontal * 0.05),        
          child: Column(
          children: [
            // 1. Categories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < categories.length; i++)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = i;
                    });
                  },
                  child: long_button(
                    button_name: categories[i],
                    backgroundColor: selected == i ? Colors.blue : Colors.white,
                    textColor: selected == i ? Colors.white : Colors.black,
                    height: screenVertical * 0.05,
                    
                  )),
                
              ],
            ),

            // 2. Search bar and filter
            Container(
              
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                searchBar(
                  width: 0.65, 
                  searchHints: "Search Delivery Task",
                  controller: TextEditingController(),
                  onChanged: (value) => {},
                  ),
                filter_button()
              ],
            ),
            ),
            SizedBox(height: 10,),

            // 3. Delivery List
            Expanded(
              child: Container(
              height: screenVertical * 0.6,
              width: screenHorizontal * 0.9,
              // margin: EdgeInsets.symmetric(horizontal: screenHorizontal * 0.05),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (context) => driver_task_detail_page(condition: 2,)));
                    },
                    child: delivery_task_list_card(),
                  );
                }),
            ))

          ],
        
        ),
      ),
    );
  }
}

class delivery_task_list_card extends StatefulWidget {
  const delivery_task_list_card({super.key});

  @override
  State<delivery_task_list_card> createState() => _delivery_task_list_cardState();
}

class _delivery_task_list_cardState extends State<delivery_task_list_card> {
  @override
  Widget build(BuildContext context) {
    double screenHorizontal = MediaQuery.of(context).size.width;
    double screenVertical = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenHorizontal*0.05, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          // 1. Food Name
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Food Name",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
          ),

          // 2. From
          Row(
            children: [
              SizedBox(width: 10),
              Icon(
                Icons.drive_eta_outlined,
                color: Colors.blue[800],
              ),
              SizedBox(width: 10),
              Text(
                "From: ",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                "Restaurant Name",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          // 3. Destination
          Row(
            children: [
              SizedBox(width: 10),
              Icon(
                Icons.location_on,
                color: Colors.blue[800],
              ),
              SizedBox(width: 10),
              Text(
                "To: ",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                "Customer Name",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          // 4. Quantity
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Quantity: ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  "1",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          // 5. Income
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Income: ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  "RM 10.00",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green[800],
                  ),
                ),
              ],
            ),
          ),

          // 6. Time
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Time: ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  "10:00 AM",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
